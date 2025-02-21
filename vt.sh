#!/bin/bash


echo -e "This Script Takes in | domain (provide txt file if more than one) |\n"
echo -e "./vt.sh ipaddr.txt \n"

#args
ipaddr=$1

# creating required directories
pwd=$(pwd)

if [ ! -d "resultfolder" ]; then
	mkdir $pwd/resultfolder
else 
	echo -e "[+] file already exist \n"
fi

# assigning Ips/Domains to vars
if [ -f $ipaddr ]; then
	IFS=$'\r\n' GLOBIGNORE='*' command eval  'IPs=($(cat $ipaddr))'
fi

# running vt itself
echo -e "[+] running IPs through Virustotal \n"

for line in "${IPs[@]}"
do
	curl --request GET \
		--url https://www.virustotal.com/api/v3/ip_addresses/$line \
		--header 'accept: application/json' \
		--header 'x-apikey: [API KEY HEREEEEE!!!]' \
		> $pwd/resultfolder/out.json
done

echo '[+] scan has finished!!!!'