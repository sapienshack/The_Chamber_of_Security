#!/bin/bash

domain=$1
RED="\033[1;31m"
GREEN='\033[0;32m'
RESET="\033[0m"

subdomain_path=$domain/subdomains
https_screenshot_path=$domain/screenshots_https
http_screenshot_path=$domain/screenshots_http
scan_path=$domain/scans

if [ ! -d "$domain" ];then
	mkdir $domain
fi

if [ ! -d "$subdomain_path" ];then
	mkdir $subdomain_path
fi

if [ ! -d "$https_screenshot_path" ];then
	mkdir $https_screenshot_path
fi

if [ ! -d "$http_screenshot_path" ];then
	mkdir $http_screenshot_path
fi

if [ ! -d "$scan_path" ];then
	mkdir $scan_path
fi

echo -e "${RED} [+] Launching subfinder ... ${RESET}"
subfinder -d $domain > $subdomain_path/found.txt
echo -e "${GREEN} [+] Done subfinder scan... ${RESET}"

echo -e "${RED} [+] Launching assetfinder ... ${RESET}"
assetfinder $domain >> $subdomain_path/found.txt
echo -e "${GREEN} [+] Done assetfinder scan... ${RESET}"

echo -e "${RED} [+] Finding Alive Subdomain ... ${RESET}"
rm -f $subdomain_path/alive.txt
cat $subdomain_path/found.txt | grep .$domain | sort -u | httprobe | tee -a $subdomain_path/alive.txt | nl
echo -e "${GREEN} [+] All alive Subdomain at $subdomain_path/alive.txt... ${RESET}"

echo -e "${RED} [+] Seperating http and https subdomain ... ${RESET}"
cat $subdomain_path/alive.txt | grep https: > $subdomain_path/https_alive.txt
cat $subdomain_path/alive.txt | grep http: > $subdomain_path/http_alive.txt
echo -e "${GREEN} [+] All alive HTTPS Subdomain at $subdomain_path/https_alive.txt... ${RESET}"
echo -e "${GREEN} [+] All alive HTTP Subdomain at $subdomain_path/http_alive.txt... ${RESET}"


echo -e "${RED} [+] Taking Screenshot of alive subdomain ... ${RESET}"
cat $subdomain_path/https_alive.txt | sed 's/https\?:\/\///' > $subdomain_path/https_alive_sc.txt
cat $subdomain_path/http_alive.txt | sed 's/http\?:\/\///' > $subdomain_path/http_alive_sc.txt
gowitness file -f $subdomain_path/https_alive_sc.txt -P $https_screenshot_path
mv gowitness.sqlite3 $https_screenshot_path/gowitness.sqlite3
sqlite3 $https_screenshot_path/gowitness.sqlite3 "SELECT url from urls where response_code=200" > 200_https_alive.txt
gowitness file -f $subdomain_path/http_alive_sc.txt -P $http_screenshot_path 
mv gowitness.sqlite3 $https_screenshot_path/gowitness.sqlite3
sqlite3 $https_screenshot_path/gowitness.sqlite3 "SELECT url from urls where response_code=200" > 200_http_alive.txt
mv 200_https_alive.txt $domain/200_https_alive.txt 
mv 200_http_alive.txt $domain/200_http_alive.txt







