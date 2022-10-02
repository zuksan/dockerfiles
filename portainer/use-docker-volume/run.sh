sudo docker run -d -p 9000:9000 --restart=always --name portainer \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    docker.io/portainer/portainer