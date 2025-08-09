local cmd = vim.cmd
local api = vim.api
local map = vim.keymap.set
local mapopts = {noremap = true, silent = true}
local o = vim.o
local g = vim.g

-- Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'catppuccin/nvim', as = 'catppuccin'}
  use 'christoomey/vim-tmux-navigator'
  use 'editorconfig/editorconfig-vim'
  use 'folke/which-key.nvim'
  use 'folke/trouble.nvim'
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path'
    }
  }
  use 'lewis6991/gitsigns.nvim'
  use 'mzlogin/vim-markdown-toc'
  use 'neovim/nvim-lspconfig'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = {'nvim-lua/plenary.nvim'}}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'}
  use {'nvim-lualine/lualine.nvim'}
end)

-- Settings
o.compatible = false
o.encoding = 'UTF-8'
o.fileencodings = 'UTF-8'
o.number = true
o.relativenumber = true
o.wrap = true
o.signcolumn = 'yes'
o.cursorline = true
o.colorcolumn = '100'
o.expandtab = true
o.softtabstop = 2
o.tabstop = 2
o.shiftwidth = 2
o.swapfile = false
o.wb = false
o.spell = true
o.clipboard = 'unnamedplus'
vim.opt_global.completeopt = {'menu', 'menuone', 'noselect'}
if vim.fn.executable 'rg' == 1 then o.grepprg = 'rg --vimgrep --no-heading --smart-case' end
g.mapleader = ' '
g.maplocalleader = ' '
o.termguicolors = true
cmd.colorscheme 'catppuccin-mocha'

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin-mocha',
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''}
  }
}

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash', 'javascript', 'lua', 'markdown', 'markdown_inline', 'python', 'query', 'toml', 'sql',
    'terraform', 'typescript', 'yaml'
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = {enable = true, disable = {}, additional_vim_regex_highlighting = false},
  indent = {enable = true}
}

-- telescope
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {['<esc>'] = actions.close},
      n = {['<esc>'] = actions.close, ['q'] = actions.close}
    },
    file_ignore_patterns = {'.git', 'node_modules'}
  },
  pickers = {
    buffers = {theme = 'ivy'},
    find_files = {theme = 'ivy'},
    live_grep = {theme = 'ivy'},
    help_tags = {theme = 'ivy'},
    spell_suggest = {theme = 'ivy'},
    oldfiles = {theme = 'ivy'},
    lsp_references = {theme = 'ivy'},
    lsp_definitions = {theme = 'ivy'},
    lsp_type_definitions = {theme = 'ivy'},
    lsp_implementations = {theme = 'ivy'},
    lsp_document_symbols = {theme = 'ivy'},
    lsp_workspace_symbols = {theme = 'ivy'},
    diagnostics = {theme = 'ivy'}
  }
}
pcall(require('telescope').load_extension, 'fzf')
local builtin = require('telescope.builtin')
map('n', '<leader>b', builtin.buffers, {unpack(mapopts), desc = 'Buffers'})
map('n', '<leader>g', builtin.live_grep, {unpack(mapopts), desc = 'Live grep'})
map('n', '<leader>f', builtin.find_files, {unpack(mapopts), desc = 'Files'})
map('n', '<leader>r', builtin.oldfiles, {unpack(mapopts), desc = 'Recent files'})
map('n', '<leader>h', builtin.help_tags, {unpack(mapopts), desc = 'Help tags'})
map('n', '<leader>es', builtin.spell_suggest, {unpack(mapopts), desc = 'Spell'})

-- LSP pickers
map('n', '<leader>lr', builtin.lsp_references, {unpack(mapopts), desc = 'LSP References'})
map('n', '<leader>ld', builtin.lsp_definitions, {unpack(mapopts), desc = 'LSP Definitions'})
map('n', '<leader>lt', builtin.lsp_type_definitions,
    {unpack(mapopts), desc = 'LSP Type Definitions'})
map('n', '<leader>li', builtin.lsp_implementations, {unpack(mapopts), desc = 'LSP Implementations'})
map('n', '<leader>ls', builtin.lsp_document_symbols,
    {unpack(mapopts), desc = 'LSP Document Symbols'})
map('n', '<leader>lw', builtin.lsp_workspace_symbols,
    {unpack(mapopts), desc = 'LSP Workspace Symbols'})
map('n', '<leader>la', builtin.diagnostics, {unpack(mapopts), desc = 'LSP Diagnostics'})

-- cmp
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local cmp = require 'cmp'
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function() if cmp.visible() then cmp.select_prev_item() end end,
                              {'i', 's', 'c'})
  }),
  sources = cmp.config.sources({{name = 'nvim_lsp'}}, {{name = 'buffer'}}),
  performance = {fetching_timeout = 2000}
})

-- LSP
local on_attach = function(_, bufnr)
  map('n', '<leader>ef', function() vim.lsp.buf.format {async = true} end,
      {unpack(mapopts), buffer = bufnr, desc = 'Format'})
  map('n', 'grd', vim.lsp.buf.definition,
      {unpack(mapopts), buffer = bufnr, desc = 'Go to definition'})
  map('n', 'grD', vim.lsp.buf.declaration,
      {unpack(mapopts), buffer = bufnr, desc = 'Go to declaration'})
  map('n', 'grh', vim.lsp.buf.hover, {unpack(mapopts), buffer = bufnr, desc = 'Hover documentation'})
end
capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local lspconfig = require('lspconfig')
local lspservers = {
  lspconfig.bashls, lspconfig.jsonls, lspconfig.phan, lspconfig.phpactor, lspconfig.pyright,
  lspconfig.terraformls, lspconfig.ts_ls, lspconfig.yamlls
}
for _, lspserver in ipairs(lspservers) do
  lspserver.setup {
    autostart = true,
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = capabilities
  }
end
lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = {'json', 'markdown', 'python', 'sh', 'terraform', 'lua'},
  init_options = {
    filetypes = {sh = 'shellcheck'},
    formatFiletypes = {
      json = 'prettier',
      javascript = 'prettier',
      markdown = 'prettier',
      python = 'ruff',
      terraform = 'terraform',
      typescript = 'prettier',
      yaml = 'prettier',
      lua = 'luaformat'
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
      ruff = {command = 'ruff', args = {'format', '--quiet', '-'}},
      prettier = {command = 'prettier', args = {'--stdin-filepath', '%filepath'}},
      terraform = {command = 'terraform', args = {'fmt', '-'}},
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
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  signs = true,
  update_in_insert = false
})
cmd('highlight! link LspReferenceText CursorColumn')
cmd('highlight! link LspReferenceRead CursorColumn')
cmd('highlight! link LspReferenceWrite CursorColumn')

-- trouble
local trouble = require('trouble')
trouble.setup {}

-- which-key
vim.o.timeout = true
vim.o.timeoutlen = 300
local wk = require('which-key')
wk.setup {icons = {mappings = false, colors = false}, show_help = false, show_keys = false}
wk.add({
  {'<leader>e', group = 'Edit'}, {'<leader>l', group = 'LSP'}, {'<leader>m', group = 'Marks'},
  {'<leader>t', group = 'Trouble'},
  {'<leader>tt', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)'}, {
    '<leader>tT',
    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    desc = 'Buffer Diagnostics (Trouble)'
  }, {'<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)'}, {
    '<leader>tl',
    '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
    desc = 'LSP Definitions / references / ... (Trouble)'
  }, {'<leader>tL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)'},
  {'<leader>tQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)'}, -- Marks
  {'<leader>ml', builtin.marks, desc = 'List all marks'}, {
    '<leader>ms',
    function()
      local mark = vim.fn.input('Set local mark: ')
      if mark ~= '' then vim.cmd('mark ' .. mark) end
    end,
    desc = 'Set local mark'
  }, {
    '<leader>mS',
    function()
      local mark = vim.fn.input('Set global mark: ')
      if mark ~= '' then vim.cmd('mark ' .. mark:upper()) end
    end,
    desc = 'Set global mark'
  }, {
    '<leader>md',
    function()
      local mark = vim.fn.input('Delete mark: ')
      if mark ~= '' then vim.cmd('delmark ' .. mark) end
    end,
    desc = 'Delete mark'
  }, {'<leader>mD', '<cmd>delmarks!<cr>', desc = 'Delete all local marks'},
  {'<leader>mG', '<cmd>delmarks A-Z<cr>', desc = 'Delete all global marks'}
})

