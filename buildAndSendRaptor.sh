#!/bin/bash
# build then send to server

version=1.1.0
user=brthomas
dev=ilmnirm0ad623
test=ilmocdt0dz630

red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)

cd ~/workspaces/git/raptor || exit

gitStatus=$(git status --short)
wait

if [[ "$gitStatus" != '' ]] 
then
  printf "%s\nYou have uncommited changes\nCommit or stash your changes before running this script\n" "${red}"
  printf "%s\n$gitStatus" "${white}"
  
else 
  printf "%s\n***************************\n" "${red}"
  printf "Deleting node_modules to prevent eperm error during npm install\n"
  printf "***************************\n%s" "${white}"

  # delete node_modules to prevent eperm error
  rm -rf ~/workspaces/git/raptor/raptor-client/node_modules
  wait
  printf "%s\n***************************\n" "${green}"
  printf "Done cleaning node_modules \n\n"
  printf "Beginning build \n"
  printf "***************************\n%s" "${white}"
  sleep 2

  # build
  mvn clean install -Dmaven.wagon.http.ssl.insecure=true
  code=$?
  
  if [[ "$code" -ne 0 ]]
  then
    printf "%s\n***************************\n" "${red}"
    printf "Maven Build Failed -- Stopping Script and Exiting :(\n"
    printf "***************************\n"
  else 
    printf "%s\n***************************\n" "${green}"
    printf "Done Building \n"
    printf "Copying War to /tmp/raptor.war \n"
    printf "***************************\n%s" "${white}"
    sleep 1

    #move the war and rename
    cp raptor-server/target/raptor-server-${version}.war /tmp/raptor.war
    wait

    printf "%s\n***************************\n" "${green}"
    printf "Copied \n"
    printf "Sending to 630 \n"
    printf "***************************\n%s" "${white}"

    # send to 630
    scp /tmp/raptor.war ${user}@${test}:/tmp/
    wait

    printf "%s\n***************************\n" "${green}"
    printf "Sent to 630 \n"
    printf "Sending to 623 \n"
    printf "***************************\n%s" "${white}"

    # send to 623
    scp /tmp/raptor.war ${user}@${dev}:/tmp/
    wait

    printf "%s\n***************************\n" "${green}"
    printf "Sent to 630 \n"
    printf "Sending to AWS \n"
    
    # send to 630
    scp -i ~/.ssh/aws.raptor.pem /tmp/raptor.war ec2-user@ec2-54-70-162-128.us-west-2.compute.amazonaws.com 
    wait
   
    printf "%s\n***************************\n" "${green}"
    printf "Done! War files uploaded! \n"
    printf "***************************\n%s" "${white}"
    
    
  fi
fi
