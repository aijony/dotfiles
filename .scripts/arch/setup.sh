#!/bin/sh

#Requires a user to be made first 
sudo pacman -Syu

sudo pacman -S sagemath svn rust cargo cscope cmake haskell-stack jupyter python3 python2 neovim git lilypond go make clang base-devel ncurses boost boost-libs mono npm nodejs aspell

cd ~/.scripts/ycmd
./install.sh

stack install apply-refact hlint stylish-haskell hasktags hoogle intero hindent