#! /bin/bash

cp -r .vim ~
cp .vimrc ~

cd ~/.vim/bundle

echo "######### Updating Apt #########"
sudo apt update
sudo apt install git

echo "######### Installing Vundle... ##########"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "######### Installing Powerline #########"
sudo apt install python3 python3-pip fontconfig wget
pip3 install --user powerline-status
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.local/share/fonts/
mkdir -p ~/.config/fontconfig/conf.d/
mv PowerlineSymbols.otf ~/.local/share/fonts/
sudo fc-cache -vf ~/.local/share/fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

echo "########## Installing build deps for YouCompleteMe, assuming base-devel is already installed. ########"
# Make sure we actually have the packages we need
sudo apt install make cmake nodejs npm clang golang-go

# Obtain Plugin
cd ~/.vim/bundle
git clone https://github.com/ycm-core/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive

# Build\Install Plugin
python3 install.py --clang-completer --system-libclang --go-completer --ts-completer

echo "########## Finalizing Plugin Installation ###########"
vim +PluginInstall +qall
echo "########## Done! ##########"
