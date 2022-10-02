# basic ssh env

## build

```bash
sudo docker build --tag=dev_vcpkg .
```

## run

```bash
sudo docker run -itd -P --restart=always --name="dev_vcpkg" dev_vcpkg
```

## use cmake

```bash
cmake -DCMAKE_TOOLCHAIN_FILE=/root/vcpkg/scripts/buildsystems/vcpkg.cmake ..
```