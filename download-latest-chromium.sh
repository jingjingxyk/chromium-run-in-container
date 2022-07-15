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

OS=$(uname -s)
echo "$OS"

:<<EOF
  download latest chromium browser
  下载最新版浏览器

# https://blog.csdn.net/evilcry2012/article/details/79056638
表中列出了一些URL特殊符号及编码 十六进制值
1.+ URL 中+号表示空格 %2B
2.空格 URL中的空格可以用+号或者编码 %20
3./ 分隔目录和子目录 %2F
4.? 分隔实际的 URL 和参数 %3F
5.% 指定特殊字符 %25
6.# 表示书签 %23
7.&amp; URL 中指定的参数间的分隔符 %26
8.= URL 中指定参数的值 %3D

EOF

# latest
chrome_linux="https://download-chromium.appspot.com/dl/Linux_x64?type=snapshots"
chrome_mac="https://download-chromium.appspot.com/dl/Mac?type=snapshots"
chrome_win="https://download-chromium.appspot.com/dl/Win_x64?type=snapshots"

# Download Chromium
## https://www.chromium.org/getting-involved/download-chromium/#downloading-old-builds-of-chrome-chromium
## https://commondatastorage.googleapis.com/chromium-browser-snapshots/

# LAST_CHANGE xml format
# LASTCHANGE_URL=https://commondatastorage.googleapis.com/chromium-browser-snapshots/
# LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"


function last_change_revison() {
  if [[ "$OS" == "Linux" ]]; then
    latest_revison_url="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"
    REVISION=$(curl -s -S $latest_revison_url )
  elif [[ "$OS" == "Darwin" ]]; then
    latest_revison_url="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac%2FLAST_CHANGE?alt=media"
    REVISION=$(curl -s -S $latest_revison_url )
  else
     latest_revison_url="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Win_x64%2FLAST_CHANGE?alt=media"
     REVISION=$(curl -s -S $latest_revison_url )
  fi
  return $?
}

function last_change_revison_aliyun_mirror()
{
   #  aliyun chromium mirror 并不是实时同步，因此最新版本落后一些时间
  # 最新版本
  if [[ "$OS" == "Linux" ]]; then
    latest_revison_url="https://registry.npmmirror.com/-/binary/chromium-browser-snapshots/Linux_x64/"
    res=$(curl -s $latest_revison_url  )
    REVISION=$(echo $res | jq | tail -n 10 | sed -n  "4p" | cut -d ":" -f 2 | cut -d "\"" -f 2 | sed 's/\///')
  elif [[ "$OS" == "Darwin" ]]; then
    latest_revison_url="https://registry.npmmirror.com/-/binary/chromium-browser-snapshots/Mac/"
    res=$(curl -s $latest_revison_url  )
     REVISION=$(echo $res | jq | tail -n 10 | sed -n  "4p" | cut -d ":" -f 2 | cut -d "\"" -f 2 | sed 's/\///')
  else
    latest_revison_url="https://registry.npmmirror.com/-/binary/chromium-browser-snapshots/Win_x64/"
    res=$(curl -s $latest_revison_url  )
    REVISION=$(echo $res | jq |tail -n 10 | sed -n  "4p" | cut -d ":" -f 2 | cut -d "\"" -f 2 | sed 's/\///')
  fi
  return $?
}

function get_download_url() {
  if [[ "$OS" == "Linux" ]]; then
    url="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F${1}%2Fchrome-linux.zip?alt=media"
  elif [[ "$OS" == "Darwin" ]]; then
    url="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac%2F${1}%2FFchrome-mac.zip?alt=media"
  else
    url="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Win_x64%2F${1}%2Fchrome-win.zip?alt=media"
  fi

}




function get_download_url_aliyun_mirror() {
  local revison=$1
  if [[ "$OS" == "Linux" ]]; then
    url="https://registry.npmmirror.com/-/binary/chromium-browser-snapshots/Linux_x64/${revison}/chrome-linux.zip"
  elif [[ "$OS" == "Darwin" ]]; then
    url="https://registry.npmmirror.com/-/binary/chromium-browser-snapshots/Mac/${revison}/chrome-mac.zip"
  else
     url="https://registry.npmmirror.com/-/binary/chromium-browser-snapshots/Win_x64/${revison}/chrome-win.zip"
  fi

}




function enable_proxy()
{

  export http_proxy=${PROXY_URL:-"http://127.0.0.1:8015"}
  export https_proxy=${PROXY_URL:-"http://127.0.0.1:8015"}

}

function disable_proxy()
{
    unset http_proxy;
    unset https_proxy;
}

function clean()
{
{
    # clean版本
    test -f chrome-linux.zip &&  rm -f chrome-linux.zip
    test -d chrome-linux     &&  rm -rf chrome-linux
    test -f chrome-mac.zip   &&  rm -f chrome-mac.zip
    test -d chrome-mac       &&  rm -rf chrome-mac
    test -f chrome-win.zip   &&  rm -f chrome-win.zip
    test -d chrome-win       &&  rm -rf chrome-win
} || {
    echo $?
}


}

function do_download()
{

download_url=$1
if test "$OS" = "Linux"; then
  {
    #linux
    echo 'linux'
    if [ ! -f chrome-linux.zip ]
    then
     {
            curl -L -o chrome-linux.zip $download_url
            unzip chrome-linux.zip
     }
     fi
     stat chrome-linux.zip

  }
elif test "$OS" = "Darwin"; then
  {
      if [ ! -f chrome-mac.zip ]
      then
       {
              curl -L -o chrome-mac.zip $download_url
              unzip chrome-mac.zip
       }
       fi

  }
else
  {
     #  请使用git bash 执行
     # =MINGW64_NT
      if [ ! -f chrome-win.zip ]
      then
            curl -L -o chrome-win.zip  $download_url
            unzip chrome-win.zip
      fi
  }
fi

}


use_proxy=${1:?0}
use_aliyun_mirror=${2:?0}

latest_revison_url=''
REVISION=''
url=''
download_url=''

disable_proxy
# clean

if  [[ -n "$use_proxy"  ]] && [[ $1 -eq  1 ]]
then
{
    enable_proxy
}
fi

if  [[ -n "$use_aliyun_mirror"  ]] && [[ $2 -eq  1 ]]
then
{

  last_change_revison_aliyun_mirror
  get_download_url_aliyun_mirror $REVISION

} else {

  last_change_revison
  get_download_url $REVISION

}
fi

do_download $url


if  [[ -n "$use_proxy"  ]] && [[ $1 -eq  1 ]]
then
{
    disable_proxy
}
fi
