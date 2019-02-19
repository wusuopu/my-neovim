#!/bin/bash

#virtualenv -p /usr/local/bin/python2 $PWD/provider/python/neovim2
#virtualenv -p /usr/local/bin/python3 $PWD/provider/python/neovim3
# rm -rf ~/.config/yarn
yarn global add neovim
pip2 install neovim
pip3 install neovim

pip install python-language-server

git submodule update --init --recursive

patch -p0 < patch/coc.diff

pushd coc/extensions/
yarn
popd
