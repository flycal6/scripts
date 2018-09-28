#!/bin/bash

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ws
wait
pwd

printf "\npulling apdx ws\n"
git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-apdx-ui
wait
pwd

printf "\npulling apdx ui\n"
git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ws
wait
pwd

printf "\npulling common ws\n"
git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-common-ui
wait
pwd

printf "\npulling common ui\n"

git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-correspondence-ws
wait
pwd

printf "\npulling correspondence ws\n"

git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\bizflowCommon-ws
wait
pwd

printf "\npulling bizflow common ws\n"

git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-global-ui
wait
pwd

printf "\npulling global ui\n"

git pull
wait

cd C:\\Users\\brthomas\\workspaces\\git\\afmss-global-ws
wait
pwd

printf "\npulling global ws\n"

git pull
wait



printf "\n\nFinished Pulling All Repos\n"

read