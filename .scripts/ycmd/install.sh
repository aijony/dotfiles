#!/bin/bash


cd ~/

mkdir .ycmd

cd .ycmd

sudo rm -rf ycmd
sudo rm -rf YCM-Generator

git clone https://github.com/rdnetto/YCM-Generator

git clone https://github.com/Valloric/ycmd

cd ycmd

git submodule update --init --recursive

sudo python build.py --clang-completer
sudo python build.py --all
