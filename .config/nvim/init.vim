"
" .config/nvim/init.vim
"

set nocompatible

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
call plug#end()

let g:NERDTreeWinPos = 'right'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_colors = { 'border':  ['fg', 'Normal'] }

let $FZF_DEFAULT_COMMAND = 'fdfind --follow --hidden --type file --exclude={.git}'
let $FZF_DEFAULT_OPTS = "--ansi --multi --preview 'highlight -O ansi -l {} 2> /dev/null || cat {}'"

let g:nord_cursor_line_number_background = 1
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

augroup nord-theme-overrides
  autocmd!
  autocmd ColorScheme nord highlight vimCommentTitle ctermfg=14 guifg=#8FBCBB
augroup END

let g:lightline = { 'colorscheme': 'nord', }

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
let g:ale_virtualtext_prefix = '⇐ '

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

filetype on
filetype plugin on
filetype indent on

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

colorscheme nord

set cursorline
set encoding=utf-8
set fileencodings=utf-8
set colorcolumn=100
set nospell
set number
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamedplus
set hls
set hidden
set nowrap
set noswapfile
set showcmd
set showmode
set showmatch
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
set grepprg=rg\ --vimgrep
