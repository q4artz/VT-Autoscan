#!/bin/bash
 
echo -e "This Script Takes in | IP/Domain/Hash/URL (provide txt file if more than one) |\n"
echo -e "\n ./vt.sh data.txt ip scan \n"
echo -e "\n ./vt.sh data.txt domain rescan \n"
 
#args
data=$1
type=$2
scan=$3
APIKEY="Enter API Key HERE!!!!!"

if [ "${data,,}" = "help" ]; then
    echo "help"
fi

# API need to be used
IPGet(){
    curl --request GET \
    		--url https://www.virustotal.com/api/v3/ip_addresses/$line \
    		--header 'accept: application/json' \
    		--header 'x-apikey:'. "$APIKEY" \
    		> $pwd/resultfolder/out.json
}
DomainGet(){
    curl --request GET \	
    		--url https://www.virustotal.com/api/v3/domains/$line \
     		--header 'accept: application/json' \
    	 	--header 'x-apikey:'. "$APIKEY" \
    		> $pwd/resultfolder/out.json
}
URLGet(){
    curl --request GET \
     		--url https://www.virustotal.com/api/v3/urls/$line \
       		--header 'accept: application/json' \
    	 	--header 'x-apikey:'. "$APIKEY" \
    		> $pwd/resultfolder/out.json
}
HashGet(){
    curl --request GET \
     		--url https://www.virustotal.com/api/v3/files/$line \
    	 	--header 'accept: application/json' \
       		--header 'x-apikey:'. "$APIKEY" \
    		> $pwd/resultfolder/out.json
}
IPRescan(){
    curl --request POST \
             --url https://www.virustotal.com/api/v3/ip_addresses/$line/analyse \
             --header 'accept: application/json' \
             --header 'x-apikey:'. "$APIKEY" \
}
DomainRescan(){
    curl --request POST \
             --url https://www.virustotal.com/api/v3/domains/$line/analyse \
             --header 'accept: application/json' \
             --header 'x-apikey:'. "$APIKEY" \
}
URLRescan(){
    curl --request POST \
             --url https://www.virustotal.com/api/v3/urls/$line/analyse \
             --header 'accept: application/json' \
             --header 'x-apikey:'. "$APIKEY" \
}
HashRescan(){
    curl --request POST \
             --url https://www.virustotal.com/api/v3/files/$line/analyse \
             --header 'accept: application/json' \
             --header 'x-apikey:'. "$APIKEY" \
}

# ---------------------------------------------------------------------------------------------------------------
 
# creating required directories
pwd=$(pwd)
 
if [ ! -d "resultfolder" ]; then
	mkdir $pwd/resultfolder
fi

# assigning Ips/Domains to vars
if [ -f $data ]; then
	IFS=$'\r\n' GLOBIGNORE='*' command eval  'Datas=($(cat $data))'
fi
 
# Running VT chekcs
echo -e "[+] running data through Virustotal \n"
case "${type,,}" in
 
  ip)
    if [ "${scan,,}" != "scan" ]; then
            for line in "${Datas[@]}" ; do IPRescan $scan $line $APIKEY ; done
    else
            for line in "${Datas[@]}" ; do IPGet $line $APIKEY $pwd ; done
    fi
    ;;
 
  domain)
    if [ "${scan,,}" != "scan" ]; then
            for line in "${Datas[@]}" ; do DomainRescan $line $APIKEY ; done
    else
            for line in "${Datas[@]}" ; do DomainGet $line $APIKEY $pwd ; done
    fi
    ;;
 
  url)
    if [ "${scan,,}" != "scan" ]; then
            for line in "${Datas[@]}" ; do URLRescan $line $APIKEY ; done
    else
            for line in "${Datas[@]}" ; do URLGet $line $APIKEY $pwd ; done
    fi
    ;;
 
  hash)
    if [ "${scan,,}" != "scan" ]; then
            for line in "${Datas[@]}" ; do HashRescan $line $APIKEY ; done
    else
            for line in "${Datas[@]}" ; do HashGet $line $APIKEY $pwd ; done
    fi
    ;;
esac
 
echo -e "\n[+] scan has finished!!!!"
