#!/bin/bash

green=$(tput setaf 2)
white=$(tput setaf 7)
red=$(tput setaf 1)
dir=$1

printf "%s\n***************************\n" "${red}"
printf "running raptor.war redeploy script"
printf "***************************\n%s" "${white}"

# shutdown tomcat
cd /local_apps/raptor/"${dir}"/tomcat/bin || exit

printf "%s\n***************************\n" "${green}"
printf "stopping tomcat\n"
printf "***************************\n%s" "${white}"

./shutdown.sh
wait

# do it again to make sure, as it always fails
./shutdown.sh
wait

printf "%s\n***************************\n" "${green}"
printf "tomcat stopped\n"
printf "***************************\n%s" "${white}"

# delete deployed files
cd ../webapps || exit

printf "%s\n***************************\n" "${green}"
printf "deleting raptor files\n"
printf "***************************\n%s" "${white}"

rm -rf raptor/

# delete war
printf "%s\n***************************\n" "${green}"
printf "deleting raptor war\n"
printf "***************************\n%s" "${white}"


yes "yes" | rm raptor.war

# copy over new war
printf "%s\n***************************\n" "${green}"
printf "deploying new war\n"
printf "***************************\n%s" "${white}"

cp /tmp/raptor.war .

# restart tomcat
printf "%s\n***************************\n" "${green}"
printf "restarting tomcat\n"
printf "***************************\n%s" "${white}"

cd ../bin || exit
./startup.sh
wait

printf "%s\n***************************\n" "${green}"
printf "redeploy complete!\n"
printf "***************************\n%s" "${white}"
