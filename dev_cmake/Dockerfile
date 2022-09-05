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

# keep running
CMD [ "/bin/bash" ]