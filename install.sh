#!/bin/bash

#virtualenv -p /usr/local/bin/python2 $PWD/provider/python/neovim2
#virtualenv -p /usr/local/bin/python3 $PWD/provider/python/neovim3

#source $PWD/provider/python/neovim2/bin/activate
pip2 install neovim
#source $PWD/provider/python/neovim3/bin/activate
pip3 install neovim
# rm -rf ~/.config/yarn
yarn global add neovim

pip install python-language-server

git submodule update --init --recursive

patch -p0 < patch/coc.diff

pushd plugged/coc.nvim/
yarn
popd

pushd coc/extensions/
yarn
popd
