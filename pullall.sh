#!/bin/bash

red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)

#tomcat=../../../tools/apache-tomcat-8.5.39/webapps/

failures=()
deployfailures=()
updatefailures=()
#deploy=""

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
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-sundriesx-ws"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-sundriesx-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-wcrx-ui"
                "C:\\Users\\brthomas\\workspaces\\git\\afmss-wcrx-ws"
                )

for repo in "${arr[@]}"
do
    cd "$repo" || exit
    wait
    branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    printf "%s\n***************************\n" "${red}"
    printf "pulling:%s %s %s ($branch)\n" "${green}" "${PWD##*/}" "${white}"

    gitStatus=$(git pull 2>&1)
    wait
    printf "%s\n" "$gitStatus"
    wait


    if [[ "$gitStatus" != *date. && "$gitStatus" != *Aborting ]]
    then
        if [[ "$repo" != *bizflowCustom ]]
        then
            printf "%s\n***************************\n" "${green}"
            printf "Performing 'mvn clean package' on:%s %s %s\n" "${green}" "${PWD##*/}" "${white}"
            mavenBuild=$(mvn clean package -DskipTests 2>&1)
            wait
            printf "%s\n" "$mavenBuild"
            
            if [[ "$mavenBuild" == *FAILURE* ]]
            then
                printf "%s\n***************************\n" "${red}"
                printf "%s" "${PWD##*/}"
                printf " MAVEN BUILD FAILED - WAR NOT DEPLOYED"
                printf "\n***************************\n%s" "${white}"
                failures+=("${PWD##*/}")

            elif [[ "$mavenBuild" != *FAILURE* ]]
            then
                printf "%s\n***************************\n" "${green}"
                printf "%s\nMAVEN BUILD SUCCEEDED\n" "${green}"
                # printf "Re-Deploying: ${green} ${PWD##*/}.war ${white}\n"
            fi
        
            # handle deploying of weirdly named WAR files
            # if [[ "$repo" == *globalx-ui ]]
            # then
            #     deploy=$(cp target\\afmss-global-ui.war "${tomcat}" 2>&1)
            # elif [[ "$repo" == *globalx-ws ]]
            # then
            #     deploy=$(cp target\\afmss-global-ws.war "${tomcat}" 2>&1)
            # elif [[ "$repo" == *bizflowCommon-ws ]]
            # then
            #     deploy=$(cp target\\bizflow-common-ws.war "${tomcat}" 2>&1)
            # elif [[ "$repo" == *afmssweb ]]
            # then
            #     deploy=$(cp target\\afmssweb.war "${tomcat}" 2>&1)
            # elif [[ "$repo" == *wcrx* || "$repo" == *sundriesx* ]]
            # then
            #     echo "NOT copying ${repo##*\\}.war to webapps"
            # else
            #     deploy=$(cp target\\${repo##*\\}.war "${tomcat}" 2>&1)
            # fi

            # if [[ deploy != *cannot* ]]
            # then
            #     printf "${green} ${PWD##*/}.war Deployed to Tomcat webapps/ ${white}\n"
            # else
            #     printf "%s" "${PWD##*/}"
            #     printf " deploy failed"
            #     deployfailures+=(deploy)
            # fi
        # else
        #     if [[ "$repo" == *sundriesx-ui ]]
        #     then
        #         C:\\Users\\brthomas\\tools\\scripts\\sundriesxUiBuild.sh
        #         wait
        #     fi
        fi
            
    elif [[ "$gitStatus" == *Aborting ]]
        then
            printf "%s\n***************************\n" "${red}"
            printf "%s" "${PWD##*/}"
            printf " FAILED TO UPDATE"
            printf "\n***************************\n%s" "${white}"
            updatefailures+=("${PWD##*/}")

    fi
done

printf "%s\n\nFinished Pulling All Repos\n%s" "${green}" "${white}" 

if [[ ${#updatefailures[@]} -gt 0 ]]
then
    printf "%s\n***************************\n" "${red}"
    for updateFail in "${updatefailures[@]}"
    do
        printf "%s" "$updateFail"
        printf " FAILED TO UPDATE\n"
    done
    printf "\n***************************\n"
elif [[ ${#updatefailures[@]} -lt 1 ]]
then
    printf "%s\n***************************\n" "${green}"
    printf "%sNo Git Update Failures!" "${white}"
    printf "%s\n***************************\n" "${green}"
fi

if [[ ${#failures[@]} -gt 0 ]]
then
    printf "%s\n***************************\n" "${red}"
    for buildFail in "${failures[@]}"
    do
        printf "%s" "$buildFail"
        printf " FAILED TO MAVEN BUILD\n"
    done
    printf "\n***************************\n"
elif [[ ${#failures[@]} -lt 1 ]]
then
    printf "%s\n***************************\n" "${green}"
    printf "%sNo Maven Build Failures!" "${white}"
    printf "%s\n***************************\n" "${green}"
fi

if [[ ${#deployfailures[@]} -gt 0 ]]
then
    printf "%s\n***************************\n" "${red}"
    for deployFail in "${deployfailures[@]}"
    do
        printf "%s""$deployFail"
        printf " FAILED TO DEPLOY\n"
    done
    printf "\n***************************\n"
elif [[ ${#deployfailures[@]} -lt 1 ]]
then
    printf "%s\n***************************\n" "${green}"
    printf "%sNo Deployment Failures!" "${white}"
    printf "%s\n***************************\n" "${green}"
fi

# uncomment to wait for input before ending
# read
