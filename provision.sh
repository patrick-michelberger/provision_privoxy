#!/bin/bash

sudo echo "Europe/Berlin" | sudo tee /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata

sudo apt-get update -y
sudo apt-get install -y language-pack-de

sudo docker run -p 8118:8118 pmichelberger/webcdn-privoxy:latest