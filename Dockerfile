FROM ubuntu:14.04

MAINTAINER James Huang

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/firefox && \
    echo "firefox:x:${uid}:${gid}:firefox,,,:/home/firefox:/bin/bash" >> /etc/passwd && \
    echo "firefox:x:${uid}:" >> /etc/group && \
    echo "firefox ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/firefox && \
    chmod 0440 /etc/sudoers.d/firefox && \
    chown ${uid}:${gid} -R /home/firefox

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y firefox \
    language-pack-zh-hant firefox-locale-zh-hant fonts-wqy-zenhei \
    openjdk-7-jre icedtea-plugin && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/*

ENV HOME /home/firefox
WORKDIR /home/firefox

USER firefox
CMD /usr/bin/firefox
