## china
git clone https://gitee.com/geogra/ohmyzsh.git ~/.oh-my-zsh
cp ./.zshrc ~/.zshrc
git clone https://gitee.com/yaozhijin/mirror-zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://gitee.com/lip0041/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
chsh -s $(which zsh)

mkdir -p ~/.vim/pack/plugins/{opt,start}
PLUGIN_DIR=~/.vim/pack/plugins/start
git clone https://gitee.com/mirrors_coolaj86/ctrlp.vim.git  $PLUGIN_DIR/ctrlp.vim
git clone https://gitee.com/daotoyi/vimplugin-tagbar.git    $PLUGIN_DIR/tagbar
git clone https://gitee.com/liyzcj/vim-commentary.git       $PLUGIN_DIR/vim-commentary
git clone https://gitee.com/daotoyi/VimPlugin-NERD_tree.git $PLUGIN_DIR/nerdtree
git clone https://gitee.com/yaozhijin/auto-pairs.git        $PLUGIN_DIR/auto-pairs
git clone https://gitee.com/applejwjcat/lightline.vim.git   $PLUGIN_DIR/lightline.vim
git clone https://gitee.com/Wu885542736/vim-easymotion.git  $PLUGIN_DIR/vim-easymotion
git clone https://gitee.com/mirrors_flozz/gruvbox.git       $PLUGIN_DIR/gruvbox

cp ./.vimrc ~/.vimrc
source ~/.zshrc
echo finish!

