# basic ssh env

## build

```bash
sudo docker build --tag=dev_java .
```

## run

```bash
sudo docker run -itd -P --restart=always --name="dev_java" dev_java
```