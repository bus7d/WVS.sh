#/bin/bash

#Wifi Vuln Scan

rm airvuln*
rm airdump*
echo " " >> airvuln.dump

#airmon-ng start wlan0

#ifconfig |grep wlan0mon

airodump-ng wlan0mon -w airdump --output csv &


while true;
do

#CHECKING FOR SFR WPS NULL CRACK
host=$(cat airdump*|grep "24:95:04" |cut -d "," -f 1)
check=$(cat airvuln.dump | grep "$host" )
if [ -z "$check" ]
	then
	cat airdump*|grep "24:95:04" && echo SFRCRACK_VULNERABLE: >> airvuln.dump && echo cat airdump*|grep "24:95:04"|cut -d "," -f 1 >> airvuln.dump

fi

#CHECKING FOR WEP CYPHER VULN

host=$(cat airdump*|grep WEP|cut -d "," -f 1)
if [ -f airvuln.dump ]
	then 
		check=$(cat airvuln.dump | grep "$host" )
		if [ -z "$check" ]
			then
				cat airdump* |grep WEP && echo "WEP_CYPHER_VULNERABLE:">>airvuln.dump &&
				cat airdump*|grep WEP|cut -d "," -f 1 >>airvuln.dump
		fi
fi
done
	


 
