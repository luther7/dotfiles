"
" .config/nvim/init.vim
"

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
Plug 'hashivim/vim-vaultproject'
Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree'
Plug 'mzlogin/vim-markdown-toc'
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
let g:ale_set_highlights = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1
let g:ale_floating_preview = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '<-- '

let $FZF_DEFAULT_COMMAND = 'fd --follow --hidden --exclude .git'
let $BAT_THEME = 'Nord'
let g:fzf_preview_command = 'bat --color=always --style=header,grid --line-range :300 {}'
let g:fzf_preview_filelist_command = 'fd --follow --hidden --exclude .git'
let g:fzf_preview_directory_files_command = 'fd --follow --hidden --exclude .git'

let g:ale_linters = {
\     'sh': [
\         'shellcheck'
\     ],
\     'javascript': [
\         'eslint',
\         'prettier',
\         'tsserver'
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
\         'pylint',
\         'flake8',
\         'isort',
\         'mypy',
\         'pyls'
\     ],
\     'ruby': [
\         'rubocop',
\         'solargraph'
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
\     'typescript': [
\         'eslint',
\         'prettier',
\         'tsserver'
\     ],
\     'yaml': [
\         'yamllint',
\         'prettier'
\     ]
\ }

let g:ale_fixers = {
\     'javascript': [
\         'eslint',
\         'prettier'
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
\     'sql': [
\         'sqlfmt'
\     ],
\     'terraform': [
\         'fmt'
\     ],
\     'typescript': [
\         'eslint',
\         'prettier'
\     ],
\     'yaml': [
\         'prettier'
\     ]
\ }

if has("nvim")
  au TermOpen * setlocal nonumber norelativenumber
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

nnoremap <F1> :Buffers<CR>
nnoremap <F2> :Files<CR>
nnoremap <F3> :Rg<CR>

nnoremap <F5> :ALEFix<CR>
nnoremap <F6> :ALEHover<CR>
nnoremap <F7> :ALEFindReferences<CR>
nnoremap <F8> :ALEGoToDefinition<CR>

nnoremap <F9> :NERDTreeFind<CR>

nnoremap <F10> :UndotreeToggle<CR>
