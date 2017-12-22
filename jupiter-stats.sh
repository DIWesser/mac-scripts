#! /bin/bash

echo -ne "\033[1mLoad Averages:\033[0m "
uptime | cut -d':' -f5

echo -ne "\033[1mUptime:\033[0m "
uptime -p | cut -d' ' -f2-20

echo -ne "\033[1mStorage Used:\033[0m "
df -H | grep md0 | cut -d' ' -f 30-31
echo -ne "/"
df -H | grep md0 | cut -d' ' -f 27-28
