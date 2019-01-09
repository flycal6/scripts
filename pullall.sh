#!/bin/bash

red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)

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
    printf "${red}\n***************************\n"
    printf "pulling: ${PWD##*/} ${white}\n"
    git pull
    wait
done

printf "${green}\n\nFinished Pulling All Repos\n${white}"

read