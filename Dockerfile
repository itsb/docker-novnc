FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    novnc \
    net-tools \
    ca-certificates \
    tigervnc-standalone-server \
    tigervnc-common \
    lxde \
    supervisor && \
    rm -rf /var/lib/apt/lists/*

# vnc config
RUN mkdir /root/.vnc && \
    echo password | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd && \
    touch /root/.Xauthority && \
    update-alternatives --remove-all vncconfig && \
    echo "<meta http-equiv='refresh' content='0; url=vnc.html?password=password&resize=remote&autoconnect=1'>" > /usr/share/novnc/index.html

# firefox with  ad blocker
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

ENV USER root
COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf
CMD ["/usr/bin/supervisord","-n"]

EXPOSE 6080
