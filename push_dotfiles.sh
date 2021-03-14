#!/bin/bash

for file in cat ./files.json | jq -r .files; do
    echo file;
done
