#!/bin/bash
echo Deleting old build files...

rm ./src/main/webapp/js/afmss-apdx.js
rm ./src/main/webapp/js/afmss-core.js
rm ./src/main/webapp/js/afmss-core-plugins.min.js

wait
echo Finished!

mvn clean package

wait
echo Copying new build files

cp ./target/afmss-apdx-ui/afmss-apdx.js ./src/main/webapp/js/afmss-apdx.js
cp ./target/afmss-apdx-ui/afmss-core.js ./src/main/webapp/js/afmss-core.js
cp ./target/afmss-apdx-ui/afmss-core-plugins.min.js ./src/main/webapp/js/afmss-core-plugins.min.js

wait
echo Finished!

# uncomment line below to wait for keypress before finishing
# read