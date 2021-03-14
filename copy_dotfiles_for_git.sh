#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[0;33m'
for file in $(cat ./files.json | jq -r "keys"[]); do
    dest=$(cat ./files.json | jq -r '."'$file'"');
    if test -f "$dest/$file"; then
        printf "✨ Copying ${GREEN}$dest/$file${NC} to ${GREEN}$file${NC}\n";
        cp $dest/$file $file;
    else
        printf "🥺 ${YELLOW}$dest/$file doesn't exist${NC}\n";
    fi
done
printf "💮    Job's done!   💮\n"

