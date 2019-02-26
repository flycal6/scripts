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
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-globalx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-globalx-ui"
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

    gitStatus=$(git pull 2>&1)
    wait
    printf "%s\n" "$gitStatus"
    wait

    # rebuild and redeploy WAR files for projects not running directly in eclipse tomcat
    if [[ "$gitStatus" != *date. ]]
    then
        if [[ "$repo" != *sundriesx* && "$repo" != *-common-ws  && "$repo" != *bizflowCustom ]]
        then
            printf "${green}\n***************************\n"
            printf "Performing 'mvn clean package' on:${green} ${PWD##*/} ${white}\n"
            mvn clean package
            wait
            printf "${green}\n***************************\n"
            printf "Re-Deploying: ${green} ${PWD##*/}.war ${white}\n"

            # globalx-ui and bizflowCommon war is not named like others
            if [[ "$repo" == *globalx-ui ]]
            then
                cp target\\afmss-global-ui.war ..\\..\\..\\tools\\apache-tomcat-8.5.33\\webapps\\.
            elif [[ "$repo" == *bizflowCommon-ws ]]
            then
                cp target\\bizflow-common-ws.war ..\\..\\..\\tools\\apache-tomcat-8.5.33\\webapps\\.
            else
                cp target\\${repo##*\\}.war ..\\..\\..\\tools\\apache-tomcat-8.5.33\\webapps\\.

            fi
            printf "${green} ${PWD##*/}.war Deployed to Tomcat webapps/ ${white}\n"

        else
            if [[ "$repo" == *sundriesx-ui ]]
            then
                C:\\Users\\brthomas\\tools\\scripts\\sundriesxUiBuild.sh
                wait
            fi
        fi
    fi
done

printf "${green}\n\nFinished Pulling All Repos\n${white}"

read
