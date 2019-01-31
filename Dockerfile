FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    tigervnc-standalone-server \
    tigervnc-common \
    python-numpy \
    lxde \
    supervisor && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/novnc/noVNC /noVNC && \
    git -C /noVNC checkout -b local 36bfcb0 && \
    echo "<meta http-equiv='refresh' content='0; url=vnc.html?password=password&resize=remote&autoconnect=1'>" > /noVNC/index.html && \
    git clone https://github.com/novnc/websockify /noVNC/utils/websockify && \
    git -C /noVNC/utils/websockify checkout -b local f0bdb0a && \
    rm -rf /noVNC/.git /noVNC/utils/websockify/.git

COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ENV USER root

EXPOSE 6080

RUN mkdir /root/.vnc && \
    echo password | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd && \
    touch /root/.Xauthority && \
    update-alternatives --remove-all vncconfig

CMD ["/usr/bin/supervisord","-n"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    firefox \
    gnupg && \
    echo "deb http://ppa.launchpad.net/mozillateam/xul-ext/ubuntu bionic main" > /etc/apt/sources.list.d/xul-ext.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE49EC21 && \
    apt-get update && \
    apt-get install -y --no-install-recommends webext-ublock-origin && \
    rm /etc/apt/sources.list.d/xul-ext.list && \
    rm -rf /var/lib/apt/lists/*
