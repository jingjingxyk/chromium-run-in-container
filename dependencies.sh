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



apt update -y &&  apt install -y  sudo wget
sudo apt install -y jq git unzip socat  ca-certificates  uuid uuid-runtime wget curl procps

sudo apt install -y curl vim   tini libssl-dev  && \
sudo apt install -y  python3 python3-dev python3-pip unzip zip
sudo pip3 install supervisor
sudo apt install -y xvfb libgles2-mesa libegl1-mesa
sudo apt install -y iputils-ping net-tools dnsutils iproute2 procps iputils-ping lsof
sudo apt install -y libgles2-mesa-dev libva-dev

## chromium  depend
# https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix

# libappindicator3-1  on debian 11 removed
soft_list=`xargs <<EOF
ca-certificates
fonts-liberation
libasound2
libatk-bridge2.0-0
libatk1.0-0
libc6
libcairo2
libcups2
libdbus-1-3
libexpat1
libfontconfig1
libgbm1
libgcc1
libglib2.0-0
libgtk-3-0
libnspr4
libnss3
libpango-1.0-0
libpangocairo-1.0-0
libstdc++6
libx11-6
libx11-xcb1
libxcb1
libxcomposite1
libxcursor1
libxdamage1
libxext6
libxfixes3
libxi6
libxrandr2
libxrender1
libxss1
libxtst6
lsb-release
wget
xdg-utils
fonts-ipafont-gothic
fonts-wqy-zenhei
fonts-thai-tlwg
fonts-kacst
fonts-freefont-ttf
EOF
`

sudo apt install -y $soft_list




