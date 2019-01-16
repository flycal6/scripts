#!/bin/bash

red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)

# add afmss projects to array to be pulled
declare -a arr=("C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-correspondence-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\bizflowCommon-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\bizflowDev-bizflowCustom"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-global-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-global-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-portal"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-portal-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\wisx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\wisx-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-sundriesx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-sundriesx-ui"
                )

for repo in "${arr[@]}"
do
    cd "$repo"
    wait
    branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    printf "${red}\n***************************\n"
    printf "pulling:${green} ${PWD##*/} ${white} ($branch)\n"
    git pull
    wait
done

printf "${green}\n\nFinished Pulling All Repos\n${white}"

read
