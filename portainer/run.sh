if [ ! -d "/opt/portainer/data" ]; then
    sudo mkdir -p /opt/portainer/data
fi

sudo docker run -d -p 9999:9000 --restart=always --name portainer \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /opt/portainer/data:/data \
    docker.io/portainer/portainer