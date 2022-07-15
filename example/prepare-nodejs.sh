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


node_nums=$(which node1 | wc -l)
if  test $node_nums -eq 0
then
{
  test -d node-v16.14.2-linux-x64 ||  wget https://nodejs.org/dist/v16.14.2/node-v16.14.2-linux-x64.tar.xz
  test -f node-v16.14.2-linux-x64.tar.xz && xz -d node-v16.14.2-linux-x64.tar.xz
  test -d node-v16.14.2-linux-x64 ||  tar -xvf node-v16.14.2-linux-x64.tar
  NODE_BIN_DIR=${__DIR__}/node-v16.14.2-linux-x64/bin
  nums=$(grep 'node-v16.14.2-linux-x64/bin' /etc/profile | wc -l )

  if test $nums -eq 0
  then
  {
    sudo echo "PATH=$PATH:$NODE_BIN_DIR" >> /etc/profile
  }
  fi
}
fi



