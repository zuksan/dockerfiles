# env for NETCONF & libssh

## build

```
sudo docker build --tag=netconf-research .
```

## run

```bash
sudo docker run --name netconf-research -it -P --privileged netconf-research /bin/bash
```


# SSH demo

## run

```bash
# server
# 生成 key
ssh-keygen -t ecdsa
ssh-keygen -t rsa
ssh-keygen -t dsa

# run server
./ssh_server_fork -r ./id_rsa -e ./id_ecdsa -d ./id_dsa -p 22 0.0.0.0 -v
# 注意在源码中把user和password改成当前环境的，再重新构建一遍

ssh -p $PORT $username@$IP # TRY CLIENT


./sshd_direct-tcpip -r /root/.ssh/id_rsa -d /root/.ssh/id_dsa -v -p 830 0.0.0.0

./samplesshd-cb -r /root/.ssh/id_rsa -d /root/.ssh/id_dsa -v -p 830 0.0.0.0
```


# netconf demo

- 问题记录：
  - 各个库需要checkout到发布版本
  - prototype-1495A的版本较老，需要用新的API重写
  - PS: 因为依赖的库很多，所以注意这样的情况：如果A依赖B.so，B install前移动了位置也可能导致A找不到B依赖的一些库

```bash
# 直接checkout到对应的tag

# Could NOT find PCRE2
apt-get install -y libpcre2-dev
# 忽略的依赖： valgrind, uncrustify, shunit2, expect; Doxygen

git clone https://github.com/CESNET/libyang.git -b v2.0.194
mkdir libyang/build/
cd libyang/build/ && cmake .. && make && make install && cd ~

# libnetconf2 需要 libssh；所以构建完后者需要 make install，否则 cmake 会报错
  # Could NOT find LibSSH (missing: LIBSSH_INCLUDE_DIRS LIBSSH_LIBRARIES)

git clone https://github.com/CESNET/libnetconf2.git -b v2.1.7
mkdir libnetconf2/build/
cd libnetconf2/build/ && cmake .. && make && make install && cd ~

git clone https://github.com/Meziden/Prototype-1495A.git
```
