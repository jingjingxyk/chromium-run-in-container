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
set +eux
. /etc/profile
set -eux


cd ${__DIR__}/extensions

git clone --depth=1 https://github.com/justjavac/ReplaceGoogleCDN.git

#多个扩展使用逗号分隔

EXTENSIONS_CONF=${__DIR__}/extensions/ReplaceGoogleCDN/extension
echo "$EXTENSIONS_CONF" > /tmp/extensions_conf

cd ${__DIR__}

sudo cp -f ${__DIR__}/supervisord-chromium-no-headless-no-screen.conf  /etc/supervisord.d/user-custom/
sudo echo "command=bash ${__DIR__}/chromium-run.sh" >> /etc/supervisord.d/user-custom/supervisord-chromium-no-headless-no-screen.conf
supervisorctl update
supervisorctl status




for((i=1;i<=5;i++));
do

tail -n 15 /tmp/supervisord-run-chromium-no-screen.log
sleep 1
ps -ef
done



# curl  http://192.168.3.20/json/version

# curl -x 192.168.3.20:80 http://localhost/json/version


curl  -H 'Host:localhost' http://127.0.0.1:9221/json/version

curl  -H 'Host:localhost' http://127.0.0.1:9222/json/version
curl  -H 'Host:localhost' http://127.0.0.1:9222/json/new?https://weibo.com

cd ${__DIR__}/node-chromium-test

#node chromium-remote-interface-test.js

cd ${__DIR__}


sleep 30