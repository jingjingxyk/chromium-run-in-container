FROM debian:12

RUN test -f /etc/apt//etc/apt/sources.list.d/debian.sources.save || cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.save
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources

RUN apt update -y && apt install -y curl git tini  ca-certificates  uuid uuid-runtime wget  procps
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone



RUN  apt install -y  python3 python3-pip python3-dev git \
     libssl-dev net-tools dnsutils iproute2 procps iputils-ping rsync \
     sudo  file lsb-release locales && \
     apt install -y xvfb supervisor socat privoxy

ADD ./install-build-puppeteer-dependencies.sh /install-build-puppeteer-dependencies.sh
ADD ./install-build-deps.sh /install-build-deps.sh
ADD ./install-build-deps.py /install-build-deps.py
ADD ./setup-supervisor.sh /setup-supervisor.sh
RUN chmod a+x /install-build-deps.py

RUN  bash /install-build-puppeteer-dependencies.sh
RUN  bash /install-build-deps.sh  --no-chromeos-fonts --no-arm
RUN  apt autoremove -y  && apt clean -y &&  rm -rf /var/lib/apt/lists/*

ADD ./supervisord-chromium-remote-debug-port-proxy.conf /etc/supervisord.d/user-custom/
# RUN bash  /setup-supervisor.sh

#RUN chmod a+x /entrypoint.sh
# CMD [ "/entrypoint.sh"]

#ADD ./supervisord-chromium-no-headless-no-screen.conf /etc/supervisord.d/user-custom/

EXPOSE 9222 9221

ENTRYPOINT ["tini", "--"]