#!/bin/bash


cd ~/

mkdir .ycmd

cd .ycmd

git clone https://github.com/rdnetto/YCM-Generator

cd /usr/bin

git clone https://github.com/Valloric/ycmd

cd ycmd

git submodule update --init --recursive

./build.py --all

cd ~/.spacemacs.d

mkdir private

cd private

svn checkout https://github.com/aijony/dotfiles/trunk/.spacemacs.d/private/better-auto-completion
