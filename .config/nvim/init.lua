local cmd = vim.cmd
local map = vim.keymap.set
local o = vim.o
local g = vim.g

-- Plugins

cmd([[
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'itchyny/lightline.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.2' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'shaunsingh/nord.nvim'
Plug 'tpope/vim-commentary'
Plug 'RishabhRD/popfix'
call plug#end()
]])

-- Settings

cmd('syntax on')
cmd('filetype plugin indent on')
o.compatible = false
o.encoding = 'UTF-8'
o.fileencodings = 'UTF-8'
o.number = true
o.wrap = true
o.signcolumn = 'yes'
o.cursorline = true
o.colorcolumn = '100'
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.swapfile = false
o.wb = false
o.spell = true
o.clipboard = 'unnamedplus'
vim.opt_global.completeopt = {'menu', 'menuone', 'noselect'}
local disabled_built_ins = {
  'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers', 'gzip', 'zip', 'zipPlugin', 'tar',
  'tarPlugin', 'getscript', 'getscriptPlugin', 'vimball', 'vimballPlugin', '2html_plugin',
  'logipat', 'rrhelper', 'spellfile_plugin', 'matchit'
}
for _, plugin in pairs(disabled_built_ins) do vim.g['loaded_' .. plugin] = 0 end
if vim.fn.executable 'rg' == 1 then o.grepprg = 'rg --vimgrep --no-heading --smart-case' end

-- Theme

g.nord_contrast = true
g.nord_borders = false
g.nord_disable_background = false
g.nord_uniform_diff_background = true
g.nord_italic = false
g.nord_bold = false
o.termguicolors = true
require('nord').set()
cmd("let g:lightline = { 'colorscheme': 'nord', }")

-- cmp

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
    end
  },
  window = {completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered()},
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = true})
  }),
  sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'vsnip'}}, {{name = 'buffer'}})
})
cmp.setup.filetype('gitcommit', {sources = cmp.config.sources({{name = 'buffer'}})})
cmp.setup.cmdline({'/', '?'},
                  {mapping = cmp.mapping.preset.cmdline(), sources = {{name = 'buffer'}}})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

-- LSP

local on_attach = function(client, bufnr)
  local bufopts = {noremap = true, silent = true, buffer = bufnr}
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  map('n', 'gD', vim.lsp.buf.declaration, bufopts)
  map('n', 'gd', vim.lsp.buf.definition, bufopts)
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', 'gi', vim.lsp.buf.implementation, bufopts)
  map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  map('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      bufopts)
  map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  map('n', 'gr', vim.lsp.buf.references, bufopts)
  map('n', '<space>f', function() vim.lsp.buf.format {async = true} end, bufopts)
  map('n', '<F10>', function() vim.lsp.buf.format {async = true} end, bufopts)
end
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local lspservers = {
  lspconfig.bashls, lspconfig.jsonls, lspconfig.vimls, lspconfig.yamlls
}
for _, lspserver in ipairs(lspservers) do
  lspserver.setup {
    autostart = true,
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = capabilities
  }
end
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {focusable = false})
lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = {'json', 'markdown', 'sh', 'lua', 'nix'},
  init_options = {
    filetypes = {sh = 'shellcheck'},
    formatFiletypes = {
      json = 'prettier',
      markdown = 'prettier',
      yaml = 'prettier',
      lua = 'luaformat',
      nix = 'nixfmt'
    },
    linters = {
      shellcheck = {
        sourceName = 'shellcheck',
        command = 'shellcheck',
        args = {'--format', 'json', '-'},
        debounce = 100,
        parseJson = {
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} { ${code} }',
          security = 'level'
        },
        securities = {error = 'error', warning = 'warning', info = 'info', style = 'hint'}
      }
    },
    formatters = {
      prettier = {command = 'prettier', args = {'--stdin-filepath', '%filepath'}},
      luaformat = {
        command = 'lua-format',
        args = {
          '-i', '--column-limit=100', '--column-table-limit=100', '--indent-width=2',
          '--no-use-tab', '--break-after-operator', '--double-quote-to-single-quote'
        }
      }
    }
  }
}

-- Treesitter

local parser_install_dir = vim.fn.stdpath('cache') .. '/treesitters'
vim.fn.mkdir(parser_install_dir, 'p')
vim.opt.runtimepath:append(parser_install_dir)
require'nvim-treesitter.configs'.setup {
  parser_install_dir = parser_install_dir,
  ensure_installed = {
    'bash', 'c', 'cpp', 'c_sharp', 'go', 'python', 'java', 'javascript', 'kotlin', 'lua', 'nix',
    'ruby', 'toml', 'typescript', 'vim', 'yaml'
  },
  sync_install = false,
  ignore_install = {},
  highlight = {enable = true, disable = {}, additional_vim_regex_highlighting = false},
  indent = {enable = true}
}

-- Telescope

local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {['<esc>'] = actions.close},
      n = {['<esc>'] = actions.close, ['q'] = actions.close}
    },
    file_ignore_patterns = {'.git', 'node_modules', '%.png', 'h.jpg', '%.jpeg'},
    theme = 'get_ivy',
    layout_strategy = 'flex'
  }
}

-- Mappings

local opts = {noremap = true, silent = true}
map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('n', '<space>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<space>q', vim.diagnostic.setloclist, opts)
map('n', '<F1>', '<CMD>Telescope buffers previewer=false <CR>', {noremap = true})
map('n', '<F2>', '<CMD>Telescope find_files hidden=true previewer=false <CR>', {noremap = true})
map('n', '<F3>', '<CMD>Telescope live_grep previewer=false <CR>', {noremap = true})
map('n', '<F9>', '<CMD>Telescope spell_suggest <CR>', {noremap = true})
