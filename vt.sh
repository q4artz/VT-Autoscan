#!/bin/bash

echo -e "This Script Takes in | domain (provide txt file if more than one) |\n"
echo -e "\n ./vt.sh data.txt ip \n"
echo -e "\n ./vt.sh data.txt domain \n"

#args
data=$1
type=$2
APIKEY='ENTER API KEY HEREEEE!!!!'

# Api need to be used
IPGet(){
	curl --request GET \
		--url https://www.virustotal.com/api/v3/ip_addresses/$line \
		--header 'accept: application/json' \
		--header 'x-apikey:'."$APIKEY" \
		> $pwd/resultfolder/out.json
}
DomainGet(){}
URLGet(){}
HashGet(){}

# creating required directory
pwd=$(pwd)

if [ ! -d "resultfolder" ]; then
	mkdir $pwd/resultfolder
else 
	echo -e "[+] folder already exist \n"
fi

# assigning Datas to var
if [ -f $data ]; then
	IFS=$'\r\n' GLOBIGNORE='*' command eval  'Datas=($(cat $data))'
fi

# running vt itself
echo -e "[+] running IPs through Virustotal \n"

case "{$type,,}" in

	ip)
	for line in "${Datas[@]}" ; do IPGet() $line $APIKEY $pwd ; done 
	;;
	domain)
	for line in "${Datas[@]}" ; do DomainGet() $line $APIKEY $pwd ; done 
	;;
	url)
	for line in "${Datas[@]}" ; do URLGet() $line $APIKEY $pwd ; done 
	;;
	"hash")
	for line in "${Datas[@]}" ; do HashGet() $line $APIKEY $pwd ; done 
	;;
	esac

echo '[+] scan has finished!!!!'