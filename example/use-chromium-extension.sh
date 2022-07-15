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


# 加载扩展
test -d ${__DIR__}/extensions || mkdir -p ${__DIR__}/extensions
cd ${__DIR__}/extensions

#  git clone --depth=1 https://github.com/justjavac/ReplaceGoogleCDN.git

#  多个扩展使用逗号分隔

#  EXTENSIONS_CONF=${__DIR__}/extensions/ReplaceGoogleCDN/extension

# export EXTENSIONS_CONF="${__DIR__}/extensions/extensons_1/,${__DIR__}/extensions/ReplaceGoogleCDN/extension"

cd ${__DIR__}




