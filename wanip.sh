#! /bin/bash
# This script print the computers WAN ip

# Print to file version
echo "service   | ip v4 address"
echo "--------- | -------------"
if [[ $(command -v curl) ]] ; then
    echo "icanhazip | "`curl -s https://icanhazip.com/`
fi
if [[ $(command -v dig) ]] ; then
    echo "OpenDNS   | "`dig +short myip.opendns.com @resolver1.opendns.com`
fi
if [[ $(command -v telnet) ]] ; then
    echo "telnet    | "`telnet 4.ifcfg.me 2>&1 | grep IPv4 | cut -d' ' -f4`
fi

# Print to terminal version
#echo "service   -> ip v4 address"
#echo "---------    -------------"
#echo "icanhazip ->" `curl -s https://icanhazip.com/`
#echo "OpenDNS  -->" `dig +short myip.opendns.com @resolver1.opendns.com`
#echo "telnet  --->" `telnet 4.ifcfg.me 2>&1 | grep IPv4 | cut -d' ' -f4`
