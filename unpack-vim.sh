#! /bin/bash

cp .vim ~
cp .vimrc ~

cd ~/.vim/bundle

echo "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing build deps for YouCompleteMe, assuming base-devel is already installed."
sudo pacman -S cmake
