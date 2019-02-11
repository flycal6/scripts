#!/bin/bash

green=$(tput setaf 2)
white=$(tput setaf 7)

echo Deleting old build files...

rm ./src/main/webapp/sundriesx-common.js
rm ./src/main/webapp/sundriesx-core.js
rm ./src/main/webapp/sundriesx-plugins.min.js

# adding this to prevent build failure due to calling maven clean prior to stopping tomcat
rm -rf ./target

wait
echo ${green}Finished deleting old build files!${white}

mvn clean package

wait
echo Copying new build files

cp ./target/afmss-sundriesx-ui/sundriesx-common.js ./src/main/webapp/sundriesx-common.js
cp ./target/afmss-sundriesx-ui/sundriesx-core.js ./src/main/webapp/sundriesx-core.js
cp ./target/afmss-sundriesx-ui/sundriesx-plugins.min.js ./src/main/webapp/sundriesx-plugins.min.js

wait
echo ${green}Finished copying new build files!${white}

# wait for user to hit <enter> before exiting
# read