#!/bin/bash

curl -Lo nvim.tgz https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz

tar xvzf nvim.tgz

sudo cp -r nvim-linux64/bin/* /usr/local/bin/
sudo cp -r nvim-linux64/lib/* /usr/local/lib/
sudo cp -r nvim-linux64/share/* /usr/local/share/
