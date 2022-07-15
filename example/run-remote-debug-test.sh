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


cd ${__DIR__}


supervisorctl update
supervisorctl status


for((i=1;i<=5;i++));
do

tail -n 15 /tmp/supervisord-run-chromium-no-screen.log
sleep 1
ps -ef
done

ls -lha .

# curl  http://192.168.3.20/json/version

# curl -x 192.168.3.20:80 http://localhost/json/version


curl  -H 'Host:localhost' http://127.0.0.1:9221/json/version

curl  -H 'Host:localhost' http://127.0.0.1:9222/json/version


cd ${__DIR__}/node-chromium-test

npm install --registry=https://registry.npmmirror.com
node chromium-remote-interface-test.js

cd ${__DIR__}
