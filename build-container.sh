#!/bin/bash

set -exu

if [ ! "$BASH_VERSION" ] ; then
    echo "Please do not use sh to run this script ($0), just execute it directly" 1>&2
    exit 1
fi

__DIR__=$(
  cd "$(dirname "$0")"
  pwd
)
cd ${__DIR__}


day=$(date -u +"%Y%m%dT%H%MZ")

export DOCKER_BUILDKIT=1

image=wenba100xie/chromium:debian-11-${day}
docker build -t  $image  -f Dockerfile .   --progress=plain
echo "docker run --rm --name demo -p 9222:9222  ${image}" > run-demo-test.sh

# docker push $image
