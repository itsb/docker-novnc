FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    tigervnc-standalone-server \
    tigervnc-common \
    wget \
    python \
    python-numpy \
    unzip \
    firefox \
    openbox \
    menu \
    supervisor && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/novnc/noVNC /noVNC && \
    git -C /noVNC checkout -b local 36bfcb0 && \
    ln -s /noVNC/vnc.html /noVNC/index.html && \
    git clone https://github.com/novnc/websockify /noVNC/utils/websockify && \
    git -C /noVNC/utils/websockify checkout -b local f0bdb0a && \
    rm -rf /noVNC/.git /noVNC/utils/websockify/.git

COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ENV USER root

EXPOSE 6080

RUN mkdir /root/.vnc && \
    echo password | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

CMD ["/usr/bin/supervisord","-n"]
