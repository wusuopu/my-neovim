#!/bin/bash

#virtualenv -p /usr/local/bin/python2 $PWD/provider/python/neovim2
#virtualenv -p /usr/local/bin/python3 $PWD/provider/python/neovim3

#source $PWD/provider/python/neovim2/bin/activate
pip2 install neovim
#source $PWD/provider/python/neovim3/bin/activate
pip3 install neovim
pip3 install pynvim
# rm -rf ~/.config/yarn
yarn global add neovim

# python开发环境
pip install pylint
pip install pyright

# ruby开发环境 ruby-language-server
gem install solargraph

# vue开发环境 vue-language-server
yarn global add vls

git submodule update --init --recursive

pushd coc/extensions/
yarn
popd
