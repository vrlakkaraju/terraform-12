#!/bin/bash


# Wait until instance boot up

until [[ -f /var/lib/cloud/instance/boot-finished  ]]; do
	sleep 1
done

# install nginx

sudo apt-get update
sudo apt-get -y install nginx

# start nginx

sudo service ngins start

