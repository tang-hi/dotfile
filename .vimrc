let g:mapleader = ','
set nu

syntax on

set nocompatible

set confirm

set mouse=a

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set autoread
set cindent

set autoindent
set smartindent

set hlsearch

set showmatch
set ruler

set foldenable
set fdm=syntax

set fdm=manual

set novisualbell
set laststatus=2
set relativenumber
set rnu
set termguicolors

set fillchars=vert:/

set fillchars=stl:/

set fillchars=stlnc:/

"plugin setting"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:lightline = { 'colorscheme': 'wombat',}
let g:multi_cursor_quit_key = '<Esc>'
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
let g:gruvbox_bold = '1'
let g:gruvbox_termcolors='256'
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox
set background=dark
set completeopt-=preview
nmap <F8> :TagbarToggle<CR>
set nohlsearch
set clipboard=unnamed
set clipboard=unnamedplus

