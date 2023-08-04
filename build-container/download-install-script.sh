
__DIR__=$(
  cd "$(dirname "$0")"
  pwd
)
cd ${__DIR__}/../build-container/



while [ $# -gt 0 ]; do
  case "$1" in
  --proxy)
    export HTTP_PROXY="$2"
    export HTTPS_PROXY="$2"
    export NO_PROXY="127.0.0.1,localhost,127.0.0.0/8,10.0.0.0/8,100.64.0.0/10,172.16.0.0/12,192.168.0.0/16,198.18.0.0/15,169.254.0.0/16"
    shift
    ;;
  --*)
    echo "Illegal option $1"
    ;;
  esac
  shift $(($# > 0 ? 1 : 0))
done

curl  https://chromium.googlesource.com/chromium/src/+/refs/heads/main/build/install-build-deps.sh?format=TEXT | base64 --decode > install-build-deps.sh
curl  https://chromium.googlesource.com/chromium/src/+/refs/heads/main/build/install-build-deps.py?format=TEXT | base64 --decode > install-build-deps.py