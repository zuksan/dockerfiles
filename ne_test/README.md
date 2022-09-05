
## init

```bash

set -v

# 设密码，打开ssh server
sudo docker exec -it ne_test_`whoami` /bin/bash -c "\
    passwd && \
    service ssh start"

# 网络配置
sudo docker exec -it ne_test_`whoami` /bin/bash -c "\
    sudo ip link add net_bd_scc type veth && \
    sudo ip link add net_bd_efi type veth && \
    sudo ip addr add 192.168.0.250/16 dev net_bd_scc && \
    sudo ip addr add 192.168.0.251/16 dev net_bd_scc && \
    sudo ip addr add 192.168.0.252/16 dev net_bd_efi && \
    sudo ip addr add 192.168.0.9/16 dev net_bd_efi && \
    sudo ip link set net_bd_scc address 00:10:10:10:00:01 && \
    sudo ip link set net_bd_efi address 00:10:10:10:00:15 && \
    sudo ip link set net_bd_scc up && \
    sudo ip link set net_bd_efi up"

# 提供连接代码库所需配置
sudo docker cp ~/.ssh ne_test_`whoami`:/root/
sudo docker cp ~/.gitconfig ne_test_`whoami`:/root/.gitconfig

```