# env for vscode extension dev

## build

```bash
sudo docker build --tag=vsce-dev .
```

## run

```bash
sudo docker run --name vsce-dev -it -P --restart=always vsce-dev /bin/bash
```