#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

declare -a arr=("C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-correspondence-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\bizflowCommon-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-global-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-global-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-sundriesx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-sundriesx-ui"
                )

for repo in "${arr[@]}"
do
    cd "$repo"
    wait
    printf "\n***************************\n"
    printf "pulling: "
    pwd
    git pull
    wait
done

printf "${bold}\n\nFinished Pulling All Repos\n${normal}"

read