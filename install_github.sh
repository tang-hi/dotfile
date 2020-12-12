#!/bin/sh
## github 
## zsh set
ROOT=/home/$USER
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ./.zshrc ~/.zshrc

if [ ! -d "$ROOT/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "$ROOT/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
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
    git clone https://github.com/kien/ctrlp.vim.git             $PLUGIN_DIR/ctrlp.vim
fi

if [ ! -d "$PLUGIN_DIR/tagbar" ]; then
    git clone https://github.com/preservim/tagbar.git           $PLUGIN_DIR/tagbar
fi

if [ ! -d "$PLUGIN_DIR/vim-commentary" ]; then
    git clone https://github.com/tpope/vim-commentary.git       $PLUGIN_DIR/vim-commentary
fi

if [ ! -d "$PLUGIN_DIR/nerdtree" ]; then
    git clone https://github.com/preservim/nerdtree.git         $PLUGIN_DIR/nerdtree
fi

if [ ! -d "$PLUGIN_DIR/auto-pairs" ]; then
    git clone https://github.com/jiangmiao/auto-pairs.git       $PLUGIN_DIR/auto-pairs
fi

if [ ! -d "$PLUGIN_DIR/lightline.vim" ]; then
    git clone https://github.com/itchyny/lightline.vim.git      $PLUGIN_DIR/lightline.vim
fi

if [ ! -d "$PLUGIN_DIR/vim-easymotion" ]; then
    git clone https://github.com/easymotion/vim-easymotion.git  $PLUGIN_DIR/vim-easymotion
fi

if [ ! -d "$PLUGIN_DIR/gruvbox" ]; then
    git clone https://github.com/morhetz/gruvbox.git            $PLUGIN_DIR/gruvbox
fi

sudo apt install build-essential cmake vim-nox python3-dev

if [ ! -d "$PLUGIN_DIR/YouCompleteMe" ]; then
    git clone https://github.com/ycm-core/YouCompleteMe.git     $PLUGIN_DIR/YouCompleteMe
fi

cp ./.vimrc ~/.vimrc
cd $PLUGIN_DIR/YouCompleteMe

git submodule update --init --recursive
python3 install.py --clangd-completer

echo -e "\033[0;32m successful! \033[0m"

