#!/bin/bash

red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)

tomcat=../../../tools/apache-tomcat-8.5.39/webapps/

failures=()
deployfailures=()
deploy=""

# add afmss projects to array to be pulled
declare -a arr=("C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-correspondence-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\bizflowCommon-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\bizflowDev-bizflowCustom"
                "C:\\Users\\brthomas\\workspaces\\git\\bizflowDev-afmssweb"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-globalx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-globalx-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-portal"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-portal-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-usermgmnt-ws"
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


    if [[ "$gitStatus" != *date. ]]
    then
        if [[ "$repo" != *bizflowCustom ]]
        then
            printf "${green}\n***************************\n"
            printf "Performing 'mvn clean package' on:${green} ${PWD##*/} ${white}\n"
            mavenBuild=$(mvn clean package -DskipTests 2>&1)
            wait
            printf "%s\n" "$mavenBuild"
            
            if [[ "$mavenBuild" == *FAILURE* ]]
            then
                printf "${red}\n***************************\n"
                printf "%s" "${PWD##*/}"
                printf " MAVEN BUILD FAILED - WAR NOT DEPLOYED"
                printf "\n***************************\n${white}"
                failures+=(${PWD##*/})

            elif [[ "$mavenbuild" != *FAILURE* ]]
            then
                printf "${green}\n***************************\n"
                printf "Re-Deploying: ${green} ${PWD##*/}.war ${white}\n"
            fi
        
            # handle deploying of weirdly named WAR files
            if [[ "$repo" == *globalx-ui ]]
            then
                deploy=$(cp target\\afmss-global-ui.war "${tomcat}" 2>&1)
            elif [[ "$repo" == *globalx-ws ]]
            then
                deploy=$(cp target\\afmss-global-ws.war "${tomcat}" 2>&1)
            elif [[ "$repo" == *bizflowCommon-ws ]]
            then
                deploy=$(cp target\\bizflow-common-ws.war "${tomcat}" 2>&1)
            elif [[ "$repo" == *afmssweb ]]
            then
                deploy=$(cp target\\afmssweb.war "${tomcat}" 2>&1)
            # elif [[ "$repo" == *apdx* ]]
            # then
            #     echo "not copying apdx to webapps"
            else
                deploy=$(cp target\\${repo##*\\}.war "${tomcat}" 2>&1)
            fi

            if [[ deploy != *cannot* ]]
            then
                printf "${green} ${PWD##*/}.war Deployed to Tomcat webapps/ ${white}\n"
            else
                printf "%s" "${PWD##*/}"
                printf " deploy failed"
                deployfailures+=(deploy)
            fi
        # else
        #     if [[ "$repo" == *sundriesx-ui ]]
        #     then
        #         C:\\Users\\brthomas\\tools\\scripts\\sundriesxUiBuild.sh
        #         wait
        #     fi
        fi
    fi
done

printf "${green}\n\nFinished Pulling All Repos\n${white}"

if [[ ${#failures[@]} > 0 ]]
then
    printf "${red}\n***************************\n"
    for buildFail in "${failures[@]}"
    do
        printf $buildFail
        printf " FAILED\n"
    done
    printf "\n***************************\n"
elif [[ ${#failures[@]} < 1 ]]
then
    printf "${green}\n***************************\n"
    printf "${white}No Maven Build Failures!"
    printf "${green}\n***************************\n"
fi

if [[ ${#deployfailures[@]} > 0 ]]
then
    printf "${red}\n***************************\n"
    for deployFail in "${deployfailures[@]}"
    do
        printf $deployFail
        printf " FAILED\n"
    done
    printf "\n***************************\n"
elif [[ ${#deployfailures[@]} < 1 ]]
then
    printf "${green}\n***************************\n"
    printf "${white}No Deployment Failures!"
    printf "${green}\n***************************\n"
fi
read
