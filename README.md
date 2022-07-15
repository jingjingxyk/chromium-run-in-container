# chromium-run-in-container-tools
> chromium run container tools


## use latest gcc 
```shell

echo 'deb http://deb.debian.org/debian testing main' >> /etc/apt/sources.list
apt install -y build-essential gcc g++ cmake 

```
## reference 
1. [chromium install deps](https://chromium.googlesource.com/chromium/src/+/main/build/install-build-deps.sh)
2. [puppeteer chrome-headless-do-launch-on-unix](https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix)
3. [docker intall docs ](https://docs.docker.com/engine/install/debian/)
4. [noVNC](https://github.com/novnc/noVNC.git)
4. [websockify](https://github.com/novnc/websockify.git)
4. [tigervnc](https://tigervnc.org/)

