#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
BLUE='\033[0;36m'
PURPLE='\033[0;35m'
for file in $(cat ./files.json | jq -r "keys"[]); do
    dest=$(cat ./files.json | jq -r '."'$file'"');
    if test -f "$dest/$file"; then
        printf "${RED}$dest/$file already exists. ${YELLOW}Making backup at ${PURPLE}$dest/$file.smus.old${NC}\n"
        mv $dest/$file $dest/$file.smus.old
    fi
    if test ! -f "$dest/$file"; then
        printf "✨ Copying ${GREEN}$file${NC} to ${GREEN}$dest/$file${NC}\n";
        cp $file $dest/$file;
    else
        printf "${RED}$dest/$file is still there for some reason${NC}\n";
    fi
done
printf "💮    Job's done!   💮\n"
