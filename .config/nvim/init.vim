"
" .config/nvim/init.vim
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
" set nowrap
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
" set nospell
set cc=100
set clipboard=unnamedplus

set rtp+=~/.fzf
call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'calviken/vim-gdscript3'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'hashivim/vim-packer'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-vagrant'
Plug 'itchyny/lightline.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
call plug#end()

colorscheme nord
set background=dark

let g:NERDTreeWinPos = 'right'

let g:lightline = { 'colorscheme': 'nord', }
set noshowmode

highlight ExtraWhitespace ctermbg='grey'

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1

let g:ale_linters = {
\     'sh': [
\         'shellcheck'
\     ],
\     'javascript': [
\         'eslint',
\         'prettier-eslint'
\     ],
\     'json': [
\         'jq',
\         'prettier'
\     ],
\     'markdown': [
\         'prettier'
\     ],
\     'python': [
\         'black',
\         'flake8',
\         'isort',
\         'mypy',
\         'pyls'
\     ],
\     'ruby': [
\         'rubocop',
\         'solargraph'
\     ],
\     'rust': [
\         'cargo',
\         'rls',
\         'rustc',
\         'clippy',
\         'rustfmt'
\     ],
\     'scala': [
\         'sbtserver'
\     ],
\     'sql': [
\         'sqlfmt'
\     ],
\     'terraform': [
\         'fmt'
\     ],
\     'yaml': [
\         'yamllint',
\         'prettier'
\     ]
\ }

let g:ale_fixers = {
\     'javascript': [
\         'eslint',
\         'prettier-eslint'
\     ],
\     'json': [
\         'jq',
\         'prettier'
\     ],
\     'markdown': [
\         'prettier'
\     ],
\     'python': [
\         'black',
\         'isort'
\     ],
\     'ruby': [
\         'rubocop'
\     ],
\     'rust': [
\         'cargo'
\     ],
\     'sql': [
\         'sqlfmt'
\     ],
\     'terraform': [
\         'fmt'
\     ],
\     'yaml': [
\         'prettier'
\     ]
\ }

let g:ale_linters = {'python': ['pylint'], 'ruby': ['solargraph', 'rubocop'], }
let g:ale_fixers = {'python': ['black'], 'ruby': ['solargraph', 'rubocop']}

if has("nvim")
  au TermOpen * setlocal nonumber norelativenumber
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

nnoremap <F2> :Buffers<CR>
nnoremap <F3> :GFiles<CR>
nnoremap <F4> :Rg<CR>

nnoremap <F5> :ALEFix<CR>
nnoremap <F6> :ALEFindReferences<CR>
nnoremap <F7> :ALEGoToDefinition<CR>
nnoremap <F8> :ALEHover<CR>

nnoremap <F9> :NERDTreeFind<CR>
