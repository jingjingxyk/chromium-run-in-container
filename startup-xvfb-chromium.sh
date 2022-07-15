#!/bin/bash

set -exu

if [ ! "$BASH_VERSION" ]; then
  echo "Please do not use sh to run this script ($0), just execute it directly" 1>&2
  exit 1
fi

__DIR__=$(cd "$(dirname "$0")";pwd)
cd ${__DIR__}

uuid=$(cat /proc/sys/kernel/random/uuid)
user_data_dir="/tmp/${uuid}"
if [ ! -d $user_data_dir ] ;then
  mkdir $user_data_dir
fi
export GOOGLE_API_KEY="no"
export GOOGLE_DEFAULT_CLIENT_ID="no"
export GOOGLE_DEFAULT_CLIENT_SECRET="no"

#linux
echo 'linux'


xvfb-run  -s "-terminate -screen 0 1920x1080x24" ${__DIR__}/chrome-linux/chrome --user-data-dir=$user_data_dir \
--start-maximized \
--remote-debugging-port=9221 \
--auto-open-devtools-for-tabs \
--enable-remote-extensions  \
--enable-extensions \
--disable-gpu \
--use-gl=egl \
--no-sandbox \
--enable-logging=stderr --v=1 \
--force-webrtc-ip-handling-policy=disable_non_proxied_udp \
--disable-dev-shm-usage \
--disable-software-rasterizer \
"about:blank"

