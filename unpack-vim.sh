#! /bin/bash

cp -r .vim ~
cp .vimrc ~

cd ~/.vim/bundle

echo "######### Installing Vundle... ##########"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "######### Installing Powerline #########"
sudo pacman -S python-pip fontconfig
sudo pip333 install --user powerline-status
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.local/share/fonts/
mkdir -p ~/.config/fontconfig/conf.d/
mv PowerlineSymbols.otf ~/.local/share/fonts/
sudo fc-cache -vf ~/.local/share/fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

echo "########## Installing build deps for YouCompleteMe, assuming base-devel is already installed. ########"
# Make sure we actually have the packages we need
sudo pacman -S cmake nodejs npm

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
