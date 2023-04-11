#!/bin/bash

sudo apt update

sudo apt upgrade -y

./install_nvim.sh

git clone https://github.com/kristianreyes7/nvim.git ~/.config/nvim
