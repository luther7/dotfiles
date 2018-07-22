runtime! archlinux.vim

set nocompatible
set nu
set history=4000

syntax on
filetype on
filetype plugin on
filetype indent on

set cursorline

set ruler
set number
set nowrap
set showcmd
set showmode
set showmatch
set matchtime=4

set hlsearch
set incsearch
set smartcase

set expandtab
set smarttab
set shiftround

set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2

set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B

set selection=inclusive
set selectmode=mouse,key

set backspace=indent,eol,start

call plug#begin('~/.local/share/nvim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

colorscheme nord
set background=dark
let g:lightline = { 'colorscheme': 'nord' }

map ; :FZF
