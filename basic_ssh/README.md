# basic ssh env

## build

```bash
sudo docker build --tag=basic_ssh .
```

## run

```bash
sudo docker run -itd -P --privileged --restart=always --name="basic_ssh" basic_ssh
```