#!/bin/bash

if ! [[ -x "$(command -v cowsay)" ]]; then
    echo "Exiting. cowsay is not installed"
    exit 0
fi

if ! [[ -x "$(command -v lolcat)" ]]; then
    echo "Exiting. lolcat is not installed"
    exit 0
fi

clear
cowsay "So, I've probably mentioned that there's this CLI program called \"cowsay\"".
sleep 3 && clear
cowsay "It does pretty much what it says on the tin."
sleep 3 && clear
cowsay Well, the other day someone on reddit mentioned that it can be run recursively...
sleep 3 && clear
cowsay Well, the other day someone on reddit mentioned that it can be run recursively... | cowsay -n
sleep 3 && clear
cowsay Well, the other day someone on reddit mentioned that it can be run recursively... | cowsay -n | cowsay -n
sleep 1 && clear
cowsay Well, the other day someone on reddit mentioned that it can be run recursively... | cowsay -n | cowsay -n | cowsay -n
sleep 1 && clear
cowsay Well, the other day someone on reddit mentioned that it can be run recursively... | cowsay -n | cowsay -n | cowsay -n | cowsay -n
sleep 1 && clear
cowsay Well, the other day someone on reddit mentioned that it can be run recursively... | cowsay -n | cowsay -n | cowsay -n | cowsay -n | cowsay -n
sleep 1 && clear
cowsay Well, the other day someone on reddit mentioned that it can be run recursively... | cowsay -n | cowsay -n | cowsay -n | cowsay -n | cowsay -n | cowsay -n
sleep 1 && clear && sleep 1
cowsay Nerds are weird | lolcat
sleep 1 && clear
cowsay Nerds are weird | lolcat
sleep 1 && clear
cowsay Nerds are weird | lolcat
