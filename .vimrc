runtime! archlinux.vim

set nocompatible
filetype off

autocmd BufWritePost ~/.vimrc so %

colorscheme solarized
set background=dark

syntax enable
set cursorline
set expandtab
set modelines=0
set shiftwidth=4
set clipboard=unnamed
set synmaxcol=300
set ttyscroll=10
set encoding=utf-8
set tabstop=2
set nowrap
set number
set nowritebackup
set noswapfile
set nobackup
set hlsearch
set ignorecase
set smartcase
set noruler
set laststatus=2

highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%>80v\+/

" Maps
:imap df <Esc> 
