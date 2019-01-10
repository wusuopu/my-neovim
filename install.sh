#!/bin/sh

# rm -rf ~/.config/yarn
yarn global add neovim
pip2 install neovim
pip3 install neovim

pip install python-language-server

git submodule update --init --recursive

patch -p0 < patch/coc.diff
