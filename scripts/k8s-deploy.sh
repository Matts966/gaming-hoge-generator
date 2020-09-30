#!/bin/bash

set -ex

MANIFESTS_JSON=$(curl https://api.github.com/repos/Matts966/gaming-hoge-generator/contents/manifests)
NUM=$(echo $MANIFESTS_JSON | jq length)

for i in $( seq 0 $(($NUM - 1)) ); do
  sudo kubectl apply -f $(echo $MANIFESTS_JSON | jq .[$i].download_url)
done
