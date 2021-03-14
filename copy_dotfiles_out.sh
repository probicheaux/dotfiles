#!/bin/bash

for file in $(cat ./files.json | jq -r "keys"[]); do
    dest=$(cat ./files.json | jq -r .$file);
    echo $file : $dest
done
