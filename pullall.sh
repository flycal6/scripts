#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ws
wait
printf "\n***************************\n"
pwd

printf "${bold}\npulling apdx ws\n${normal}"
git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ui
wait
printf "\n***************************\n"
pwd

printf "${bold}\npulling apdx ui\n${normal}"
git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ws
wait
printf "\n***************************\n"
pwd

printf "${bold}\npulling common ws\n${normal}"
git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ui
wait
printf "\n***************************\n"
pwd

printf "${bold}\npulling common ui\n${normal}"

git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-correspondence-ws
wait
printf "\n***************************\n"
pwd

printf "${bold}\npulling correspondence ws\n${normal}"

git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\bizflowCommon-ws
wait
printf "\n***************************\n"
pwd

printf "${bold}\npulling bizflow common ws\n${normal}"

git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-global-ui
wait
printf "\n***************************\n"
pwd

printf "${bold}\npulling global ui\n${normal}"

git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-global-ws
wait
printf "\n***************************\n"
pwd

printf "${bold}\npulling global ws\n${normal}"

git pull
wait



printf "${bold}\n\nFinished Pulling All Repos\n${normal}"

read