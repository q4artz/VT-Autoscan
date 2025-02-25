#!/bin/bash
 
echo -e "This Script Takes in | IP/Domain/Hash/URL (provide txt file if more than one) |\n"
echo -e "\n ./vt.sh data.txt ip \n"
echo -e "\n ./vt.sh data.txt domain \n"
 
#args
data=$1
type=$2
APIKEY="Enter API Key HERE!!!!!"
 
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
	 --header 'x-apikey:'. "$APIKEY" \
> $pwd/resultfolder/out.json
}
HashGet(){
    url --request GET \
     --url https://www.virustotal.com/api/v3/files/$line \
	 --header 'x-apikey:'. "$APIKEY" \
> $pwd/resultfolder/out.json
}
 
# creating required directories
pwd=$(pwd)
 
if [ ! -d "resultfolder" ]; then
	mkdir $pwd/resultfolder
else 
	echo -e "[+] file already exist \n"
fi
 
# assigning Ips/Domains to vars
if [ -f $data ]; then
	IFS=$'\r\n' GLOBIGNORE='*' command eval  'Datas=($(cat $data))'
fi
 
# Running VT chekcs
echo -e "[+] running data through Virustotal \n"
case "{$type,,}" in
 
  ip)
    for line in "${Datas[@]}" ; do IPGet $line $APIKEY $pwd ; done
    ;;
 
  domain)
    for line in "${Datas[@]}" ; do DomainGet $line $APIKEY $pwd ; done
    ;;
 
  url)
    for line in "${Datas[@]}" ; do URLGet $line $APIKEY $pwd ; done
    ;;
 
  "hash")
    for line in "${Datas[@]}" ; do HashGet $line $APIKEY $pwd ; done
    ;;
esac
 
echo -e "\n[+] scan has finished!!!!"
