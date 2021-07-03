"
" .config/nvim/init.vim
"

autocmd!
filetype on
filetype plugin on
filetype indent on
set nocompatible
set encoding=utf-8
set fileencodings=utf-8
set number
set signcolumn=yes
set cursorline
set colorcolumn=100
set expandtab
set tabstop=2
set shiftwidth=2
set noswapfile
set nowb
set clipboard=unnamedplus
set grepprg=rg\ --vimgrep

call plug#begin("~/.local/share/nvim/plugged")
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'hashivim/vim-terraform'
Plug 'hrsh7th/nvim-compe'
Plug 'itchyny/lightline.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tsandall/vim-rego'
call plug#end()

colorscheme nord
let g:lightline = { 'colorscheme': 'nord', }

lua << EOF
-- vim.lsp.set_log_level("debug")

local lspconfig = require("lspconfig")

local servers = {
  "bashls",
  "dockerls",
  "jsonls",
  "pyright",
  "solargraph",
  "terraformls",
  "tsserver",
  "vimls",
  "yamlls"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

lspconfig.diagnosticls.setup {
  filetypes = {
    "json",
    "markdown",
    "python",
    "sh",
    "terraform",
  },
  init_options = {
   filetypes = {
     python = "flake8",
     sh = "shellcheck",
   },
   formatFiletypes = {
     json = "prettier",
     markdown = "pandoc",
     python = "black",
     terraform = "terraform",
     yaml = "prettier",
   },
   linters = {
     flake8 = {
       sourceName = "flake8",
       command = "flake8",
       debounce = 100,
       args = {
         "--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s", "-" 
       },
       offsetLine = 0,
       offsetColumn = 0,
       formatLines = 1,
       formatPattern = {
         "(\\d+),(\\d+),({A-Z}),(.*)(\\r|\\n)*$",
         {
           line = 1,
           column = 2,
           security = 3,
           message = 4
         }
       },
       securities = {
         W = "warning",
         E = "error",
         F = "error",
         C = "error",
         N = "error",
       },
     },
     shellcheck = {
       sourceName = "shellcheck",
       command = "shellcheck",
       args = {
         "--format",
         "json",
         "-"
       },
       debounce = 100,
       parseJson = {
         line = "line",
         column = "column",
         endLine = "endLine",
         endColumn = "endColumn",
         message = "${message} { ${code} }",
         security = "level",
       },
       securities = {
         error = "error",
         warning = "warning",
         info = "info",
         style = "hint",
       },
     },
   },
   formatters = {
     black = {
       command = "black",
       args = {
         "--quiet",
         "-"
       }
     },
     pandoc = {
       command = "pandoc",
       args = {
         "-t",
         "markdown"
       }
     },
     prettier = {
       command = "prettier",
       args = {
         "--stdin-filepath",
         "%filepath"
       }
     },
     terraform = {
       command = "terraform",
       args = {
         "fmt",
         "-"
       }
     },
   },
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
    treesitter = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end
EOF

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <F1> :Telescope buffers<CR>
nnoremap <F2> :Telescope find_files<CR>
nnoremap <F3> :Telescope live_grep<CR>
nnoremap <F4> :Telescope grep_string<CR>
nnoremap <F5> :Telescope lsp_definitions<CR>
" nnoremap <F6> <CR>
" nnoremap <F7> <CR>
nnoremap <F8> :Telescope lsp_code_actions<CR>
nnoremap <silent> <F9> <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <F10> :Telescope file_browser<CR>

