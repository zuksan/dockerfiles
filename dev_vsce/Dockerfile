FROM debian:latest

# Install dependencies
RUN apt update && \
    apt install -y npm vim git wget && \
    # update to latest npm
    npm install npm@latest -g && \
    # update to latest node
    npm install -g n && \
    # update current terminal path
    PATH="$PATH" && \
    # install vscode extension dev env
    npm install -g yo generator-code vsce

# config ssh server
RUN apt install -y openssh-server && \
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp && \
    sed -i '$a \
    PermitRootLogin yes\n\
    ClientAliveInterval 60\n\
    ClientAliveCountMax 3\n' /etc/ssh/sshd_config

ENTRYPOINT service ssh restart && bash

EXPOSE 22