Nging Dockerfile
=============

This repository contains Dockerfile of nginx for Docker's automated build published to the public Docker Hub Registry.

# Base Docker Image
[dockerfile/ubuntu](https://registry.hub.docker.com/u/dockerfile/ubuntu/)

# Installation

## Install Docker.

## Build and run with custom config directory

Get the latest version from github

    git https://github.com/AshDevFr/nginx-docker.git
    cd nginx-docker/

Before building the version, edit your config. Then, build it. 

    sudo docker build --force-rm=true --tag="$USER/nginx:latest" .
    
And run
(exemple if you run a cloud9-docker image)

    sudo docker run --name=nginx -d -p 80:80 -p 443:443 --link cloud9:IDE -e "IDE_SERVER_ADDR=myserver.com" -v /var/nginx/sites-enabled:/etc/nginx/sites-enabled -v /var/nginx/certs:/etc/nginx/certs -v /var/nginx/logs:/var/log/nginx -v /var/nginx/www:/var/www/html $USER/nginx
    
Enjoy !!    


