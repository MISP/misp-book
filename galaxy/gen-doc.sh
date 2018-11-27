#!/bin/bash
# This generates some of the sections of the Galaxy Documentation
# Dependencies: git, jq, bash

if [[ ! -d "misp-galaxy" ]]; then
  git clone https://github.com/MISP/misp-galaxy.git
  cd misp-galaxy
else
  cd misp-galaxy
  git pull
fi

FOLDERS='clusters vocabularies/common vocabularies/threat-actor'

for folder in ${FOLDERS}; do
  cd $folder

  for file in $(ls |grep -v README); do
    Name=$(echo ${file} |cut -f 1 -d.| tr '-' ' '| tr '_' ' ')
    Name=$(tr '[:lower:]' '[:upper:]' <<< ${Name:0:1})${Name:1}
    Description=$(jq -r .description ${file})

    echo "[${Name}](https://github.com/MISP/misp-galaxy/blob/master/${folder}/${file}) - ${Description}"
    echo ""
  done
  echo "------------------------------------------------------------------------------------"
  echo "$folder done"
  echo "------------------------------------------------------------------------------------"
  # This is ugly, but works... fix it if you do not like it.
  if [[ $folder == *'/'* ]]; then
    cd ../..
  else
    cd ..
  fi
done
