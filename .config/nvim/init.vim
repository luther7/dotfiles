"
" .vimrc
"

runtime! archlinux.vim

syntax on
filetype on
filetype plugin on
filetype indent on
set cursorline
set nocompatible
set nu
set history=4000
set ruler
set number
set nowrap
set noswapfile
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
set laststatus=2
set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B
set selection=inclusive
set selectmode=mouse,key
set backspace=indent,eol,start
set nospell
set cc=80

set rtp+=~/.fzf
call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
call plug#end()

colorscheme nord
set background=dark

let g:lightline = { 'colorscheme': 'nord', }
set noshowmode

let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_completion_enabled = 1
let g:ale_linters = {'python': ['pyls', 'flake8']}
let g:ale_fixers = {'python': ['black']}

if has("nvim")
  au TermOpen * setlocal nonumber norelativenumber
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

nnoremap <F2> :terminal<CR>
nnoremap <F3> :Files<CR>
nnoremap <F4> :GFiles<CR>
nnoremap <F5> :Buffers<CR>
nnoremap <F6> :Rg<CR>
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <F8> :NERDTreeFind<CR>
nnoremap <F9> :ALEFindReferences<CR>
nnoremap <F10> :ALEGoToDefinition<CR>
