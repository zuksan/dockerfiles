FROM ubuntu:22.04

# update basic programs
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt update -y && \
    apt install -y sudo openssh-server net-tools iproute2 iputils-ping \
        build-essential make \
        wget tar \
        git vim \
        # vcpkg
        curl zip unzip tar \
        ninja-build \
        # for vcpkg build
        pkg-config \
        && \
    # install vcpkg
    cd ~ && git clone https://github.com/Microsoft/vcpkg.git && \
    ./vcpkg/bootstrap-vcpkg.sh && \
    ./vcpkg/vcpkg integrate install

# config ssh server
RUN apt install -y openssh-server && \
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp && \
    sed -i '$a \
    PermitRootLogin yes\n\
    ClientAliveInterval 60\n\
    ClientAliveCountMax 3\n' /etc/ssh/sshd_config

ENTRYPOINT service ssh restart && bash

EXPOSE 22