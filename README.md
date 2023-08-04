# chromium-run-in-container-tools

> chromium run container tools

> 容器中运行 chromium 工具

## use latest gcc

```shell

echo 'deb http://deb.debian.org/debian testing main' >> /etc/apt/sources.list
apt install -y build-essential gcc g++ cmake 

```

## reference

1. [chromium install deps](https://chromium.googlesource.com/chromium/src/+/main/build/install-build-deps.sh)
1. [puppeteer chrome-headless-do-launch-on-unix](https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix)
1. [docker intall docs ](https://docs.docker.com/engine/install/debian/)
1. [noVNC](https://github.com/novnc/noVNC.git)
1. [websockify](https://github.com/novnc/websockify.git)
1. [tigervnc](https://tigervnc.org/)
1. [ReplaceGoogleCDN](https://github.com/justjavac/ReplaceGoogleCDN.git)

