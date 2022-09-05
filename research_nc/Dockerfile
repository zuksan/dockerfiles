FROM ubuntu:18.04

LABEL author="zuksan"

RUN apt update && \
    apt install -y vim && \
    apt install -y git net-tools iputils-ping iproute2 && \
    apt install -y cmake make libc6-dev

# update gcc 9
RUN apt install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt update && \
    apt install -y gcc-9 g++-9 && \
    apt install -y gcc-9-multilib g++-9-multilib && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 70 --slave /usr/bin/g++ g++ /usr/bin/g++-9 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 50 --slave /usr/bin/g++ g++ /usr/bin/g++-7

# ====== SSH ======

# libssh 依赖的库：zlib(libz), gcrypt,
RUN cd ~ && git clone https://github.com/madler/zlib.git -b v1.2.12 && \
    cd zlib && ./configure; make test && cd ~

RUN apt install -y libgcrypt20-dev
# 20220816 为了简化配置，以下库采用apt安装==========
apt install -y libgcrypt20-dev

# # gcrypt 归属于 gnupg，[The GnuPG Repositories](https://git.gnupg.org/)
# git clone https://dev.gnupg.org/source/libgcrypt.git -b libgcrypt-1.10.1
# apt install -y autoconf automake
# # gcrypt需要libgpg-error；libgpg-error需要gettext，高于0.14.5
#    [gettext - GNU Project - Free Software Foundation](https://www.gnu.org/software/gettext/)
# git clone https://git.savannah.gnu.org/git/gettext.git -b v0.21
# git clone git://git.gnupg.org/libgpg-error.git -b libgpg-error-1.4

# # gettext 需要 gnulib
# git clone https://git.savannah.gnu.org/git/gnulib.git -b
#    [Gnulib - GNU Portability Library - GNU Project - Free Software Foundation](https://www.gnu.org/software/gnulib/)
# git clone https://git.savannah.gnu.org/git/gnulib.git
# cd libgcrypt && ./autogen.sh --force && ./configure && make && make check && make install && cd ~
# ================================================


# libssh例子需要 cmocka 和 一系列 wrapper
# 构建 pam_wrapper 需要安装 libpam0g-dev ，是要解决这个问题：security/pam_appl.h: No such file or directory
#    [linux - pam_appl.h and pam_misc.h missing, in rshd.c source code - Stack Overflow](https://stackoverflow.com/questions/15614823/pam-appl-h-and-pam-misc-h-missing-in-rshd-c-source-code/45687143#45687143)
RUN git clone https://git.cryptomilk.org/projects/cmocka.git/ -b cmocka-1.1.5  && \
    mkdir cmocka/build/  && \
    cd cmocka/build/ && cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug .. && make && make install && cd ~  && \
    git clone git://git.samba.org/socket_wrapper.git -b socket_wrapper-1.3.4  && \
    mkdir socket_wrapper/obj/  && \
    cd socket_wrapper/obj/ && cmake .. && make && make install && cd ~  && \
    git clone git://git.samba.org/nss_wrapper.git -b nss_wrapper-1.1.12  && \
    mkdir nss_wrapper/obj/  && \
    cd nss_wrapper/obj/ && cmake .. && make && make install && cd ~  && \
    git clone git://git.samba.org/uid_wrapper.git -b uid_wrapper-1.2.9  && \
    mkdir uid_wrapper/obj/  && \
    cd uid_wrapper/obj/ && cmake .. && make && make install && cd ~  && \
    git clone git://git.samba.org/resolv_wrapper.git -b resolv_wrapper-1.1.7  && \
    mkdir resolv_wrapper/obj/  && \
    cd resolv_wrapper/obj/ && cmake .. && make && make install && cd ~  && \
    apt install -y libpam0g-dev  && \
    git clone git://git.samba.org/pam_wrapper.git -b pam_wrapper-1.1.4  && \
    mkdir pam_wrapper/obj/  && \
    cd pam_wrapper/obj/ && cmake .. && make && make install && cd ~


# 构建 libssh 需要 libssl 等一系列库
# ========== 尝试源码构建 openssl ==========
# # openssl
# git clone git://git.openssl.org/openssl.git -b OpenSSL_1_1_1
# cd openssl && ./Configure linux-x86_64 && make && make install && cd ~
#     # 重新构建注意 清理cmake缓存；make clean；
# --- 即使export也找不到 [CMake not able to find OpenSSL library - Stack Overflow](https://stackoverflow.com/questions/16248775/cmake-not-able-to-find-openssl-library)
#    export OPENSSL_ROOT_DIR=/usr/local/include/openssl && export OPENSSL_LIBRARIES=/usr/local/lib64/openssl/lib
# ---源码构建后仍然找不到，只能用apt安装了
# =========================================

RUN apt install -y libssl-dev  && \
    apt install -y openssh-server  && \
    git clone https://git.libssh.org/projects/libssh.git -b libssh-0.9.6  && \
    mkdir libssh/build  && \
    cd libssh/build && cmake -DUNIT_TESTING=ON -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DWITH_SERVER=ON -DSERVER_TESTING=ON ..

# libssh 内部有调试宏，可以使用 -DWITH_DEBUG_PACKET=ON 用来添加打印信息

EXPOSE 21
EXPOSE 22
EXPOSE 830