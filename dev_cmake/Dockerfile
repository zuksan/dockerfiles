FROM ubuntu:22.04

LABEL author="zuksan"

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt update -y && \
    apt install -y \
        build-essential gdb make wget tar git vim\
        # cmake
        cmake=3.22.1-1ubuntu1 \
        # mbedtls
        libmbedtls-dev=2.28.0-1build1

# config ssh server
RUN apt install -y openssh-server && \
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp && \
    sed -i '$a \
    PermitRootLogin yes\n\
    ClientAliveInterval 60\n\
    ClientAliveCountMax 3\n' /etc/ssh/sshd_config

ENTRYPOINT \
    # start ssh
    service ssh restart && \
    # keep running
    /bin/bash

EXPOSE 22