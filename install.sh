#!/bin/sh
## china
## zsh set
sudo apt-get install zsh
ROOT=/home/$USER
if [ ! -d "$ROOT/.oh-my-zsh" ]; then
    git clone https://gitee.com/geogra/ohmyzsh.git ~/.oh-my-zsh
fi
cp ./.zshrc ~/.zshrc

if [ ! -d "$ROOT/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://gitee.com/yaozhijin/mirror-zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "$ROOT/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://gitee.com/lip0041/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi


if [ ! -d "$ROOT/.fzf" ]; then
    git clone https://gitee.com/lip0041/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

chsh -s $(which zsh)
source ~/.zshrc

## vim set
VIM_PLUGIN=~/.vim/pack/plugins/{opt,start}
if [ ! -d "$VIM_PLUGIN" ]; then
    mkdir -p ~/.vim/pack/plugins/{opt,start}
fi
PLUGIN_DIR=~/.vim/pack/plugins/start

if [ ! -d "$PLUGIN_DIR/ctrlp.vim" ]; then
    git clone https://gitee.com/mirrors_coolaj86/ctrlp.vim.git  $PLUGIN_DIR/ctrlp.vim
fi

if [ ! -d "$PLUGIN_DIR/tagbar" ]; then
    git clone https://gitee.com/daotoyi/vimplugin-tagbar.git    $PLUGIN_DIR/tagbar
fi

if [ ! -d "$PLUGIN_DIR/vim-commentary" ]; then
    git clone https://gitee.com/liyzcj/vim-commentary.git       $PLUGIN_DIR/vim-commentary
fi

if [ ! -d "$PLUGIN_DIR/nerdtree" ]; then
    git clone https://gitee.com/daotoyi/VimPlugin-NERD_tree.git $PLUGIN_DIR/nerdtree
fi

if [ ! -d "$PLUGIN_DIR/auto-pairs" ]; then
    git clone https://gitee.com/yaozhijin/auto-pairs.git        $PLUGIN_DIR/auto-pairs
fi

if [ ! -d "$PLUGIN_DIR/lightline.vim" ]; then
    git clone https://gitee.com/applejwjcat/lightline.vim.git   $PLUGIN_DIR/lightline.vim
fi

if [ ! -d "$PLUGIN_DIR/vim-easymotion" ]; then
    git clone https://gitee.com/Wu885542736/vim-easymotion.git  $PLUGIN_DIR/vim-easymotion
fi

if [ ! -d "$PLUGIN_DIR/gruvbox" ]; then
    git clone https://gitee.com/mirrors_flozz/gruvbox.git       $PLUGIN_DIR/gruvbox
fi

sudo apt install build-essential cmake vim-nox python3-dev

if [ ! -d "$PLUGIN_DIR/YouCompleteMe" ]; then
    git clone https://gitee.com/renyongjian/YouCompleteMe.git   $PLUGIN_DIR/YouCompleteMe
fi

cp ./.vimrc ~/.vimrc
cd $PLUGIN_DIR/YouCompleteMe

git submodule update --init --recursive
python3 install.py --clangd-completer

echo -e "\033[0;32m successful! \033[0m"

