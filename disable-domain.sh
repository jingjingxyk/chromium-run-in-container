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

redirect_domain=<<EOF
127.0.0.1       update.googleapis.com   edgedl.me.gvt1.com      optimizationguide-pa.googleapis.com     safebrowsing.googleapis.com     edgedl.me.gvt1.com      accounts.google.com     r1---sn-npoe7nes.gvt1.com       r5---sn-npoe7nsd.gvt1.com       clients2.google.com     redirector.gvt1.com
::1             update.googleapis.com   edgedl.me.gvt1.com      optimizationguide-pa.googleapis.com     safebrowsing.googleapis.com     edgedl.me.gvt1.com      accounts.google.com     r1---sn-npoe7nes.gvt1.com       r5---sn-npoe7nsd.gvt1.com       clients2.google.com     redirector.gvt1.com
EOF
echo $redirect_domain
#echo $redirect_domain >> /etc/hosts