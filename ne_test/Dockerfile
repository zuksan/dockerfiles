FROM ubuntu:18.04

# update basic programs
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt update -y && \
    apt install -y sudo net-tools iproute2 iputils-ping \
        gcc libc6-dev make wget tar \
        git vim openssh-server

# update cmake
RUN apt remove --purge cmake && \
    hash -r && \
    # 下载特定版本的cmake源码并构建和安装
    apt install -y build-essential libssl-dev && \
    wget https://github.com/Kitware/CMake/releases/download/v3.19.7/cmake-3.19.7.tar.gz && \
    tar -zxvf cmake-3.19.7.tar.gz && \
    cd cmake-3.19.7 && \
    ./bootstrap && \
    make -j$(nproc) && \
    make install

# update gcc 9
RUN apt install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt update && \
    apt install -y gcc-9 g++-9 && \
    apt install -y gcc-9-multilib g++-9-multilib && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 70 --slave /usr/bin/g++ g++ /usr/bin/g++-9 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 50 --slave /usr/bin/g++ g++ /usr/bin/g++-7

# update gdb 10
RUN sudo apt install -y texinfo libncurses5-dev libncursesw5-dev && \
    wget http://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.gz && \
    tar -zxvf gdb-10.1.tar.gz && \
    cd gdb-10.1/ && \
    mkdir build && \
    cd build/ && \
    ../configure --enable-tui=yes --prefix=/opt/gdb-10.1 && \
    make -j$(nproc) && \
    sudo make install && \
    sudo update-alternatives --install /usr/bin/gdb gdb /opt/gdb-10.1/bin/gdb 70

# config ssh server
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp && \
    sed -i '$a \
    PermitRootLogin yes\n\
    ClientAliveInterval 60\n\
    ClientAliveCountMax 3\n' /etc/ssh/sshd_config && \
    service ssh start

EXPOSE 22
EXPOSE 1400
EXPOSE 5432
