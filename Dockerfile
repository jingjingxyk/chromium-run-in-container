FROM debian:11 AS builder-base
RUN apt update -y && apt install -y curl git tini  ca-certificates  uuid uuid-runtime wget  procps
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENTRYPOINT ["tini", "--"]


FROM builder-base as builder-run-env

RUN  apt update -y && apt install -y ca-certificates curl  tini python3 python3-pip python3-dev git \
     libssl-dev net-tools dnsutils iproute2 procps iputils-ping rsync \
     sudo  file lsb-release locales && \
     apt install -y xvfb supervisor socat privoxy

ADD ./dependencies.sh /dependencies.sh
ADD ./install-build-deps.sh /install-build-deps.sh


RUN  bash /dependencies.sh && \
     bash /install-build-deps.sh  --no-chromeos-fonts --no-arm && \
     apt autoremove -y  && apt clean -y && \
     rm -rf /var/lib/apt/lists/*

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

CMD [ "/entrypoint.sh"]


FROM builder-run-env

ADD ./download-latest-chromium.sh /download-latest-chromium.sh
ADD ./supervisord-chromium-remote-debug-port-proxy.conf /etc/supervisord.d/user-custom/

#ADD ./supervisord-chromium-no-headless-no-screen.conf /etc/supervisord.d/user-custom/
RUN bash /download-latest-chromium.sh 0 0

EXPOSE 9222 9221