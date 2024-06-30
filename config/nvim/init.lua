local cmd = vim.cmd
local api = vim.api
local map = vim.keymap.set
local mapopts = { noremap = true, silent = true }
local o = vim.o
local g = vim.g
local g = vim.g

-- Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- lspconfig
  use {
    'williamboman/mason.nvim',
    requires = {
      'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim',
      'j-hui/fidget.nvim', 'folke/neodev.nvim', 'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio',
      'mhartington/formatter.nvim', 'mfussenegger/nvim-lint',
      'WhoIsSethDaniel/mason-tool-installer.nvim'
    },
  }
  -- cmp
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ',
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path'
    }
  }
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter'
  }
  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1
  }
  -- which-key
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  }
  -- Theme
  use 'shaunsingh/nord.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'lewis6991/gitsigns.nvim'
  -- Utilities
  use 'RishabhRD/popfix'
  use 'christoomey/vim-tmux-navigator'
  use 'numToStr/Comment.nvim'
  use 'editorconfig/editorconfig-vim'
  use 'mzlogin/vim-markdown-toc'
end)

-- Settings
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
api.nvim_set_option("clipboard", "unnamedplus")
vim.opt_global.completeopt = { 'menu', 'menuone', 'noselect' }
if vim.fn.executable 'rg' == 1 then
  o.grepprg = 'rg --vimgrep --no-heading --smart-case'
end
g.mapleader = ' '
g.maplocalleader = ' '

-- nord
g.nord_contrast = true
g.nord_borders = false
g.nord_disable_background = false
g.nord_uniform_diff_background = true
g.nord_italic = false
g.nord_bold = false
o.termguicolors = true
require('nord').set()

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'nord',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' }
  }
}

-- Comment
require('Comment').setup()

-- treesitter
local parser_install_dir = vim.fn.stdpath('cache') .. '/treesitters'
vim.fn.mkdir(parser_install_dir, 'p')
vim.opt.runtimepath:append(parser_install_dir)
require 'nvim-treesitter.configs'.setup {
  parser_install_dir = parser_install_dir,
  ensure_installed = {
    'bash', 'python', 'java', 'javascript', 'kotlin', 'lua', 'toml',
    'typescript', 'vim', 'yaml'
  },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false
  },
  indent = { enable = true }
}

-- telescope
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = { ['<esc>'] = actions.close },
      n = { ['<esc>'] = actions.close, ['q'] = actions.close }
    },
    file_ignore_patterns = {
      '.git', 'node_modules', '%.png', 'h.jpg', '%.jpeg'
    },
    theme = 'get_ivy',
    layout_strategy = 'flex'
  }
}
pcall(require('telescope').load_extension, 'fzf')
local builtin = require('telescope.builtin')
map('n', '<leader>fb', builtin.buffers, { unpack(mapopts), desc = "Buffers" })
map('n', '<leader>fg', builtin.live_grep, { unpack(mapopts), desc = "Live grep" })
map('n', '<leader>fr', builtin.oldfiles,
  { unpack(mapopts), desc = "Recent files" })
map('n', '<leader>es', builtin.spell_suggest, { unpack(mapopts), desc = "Spell" })

-- cmp
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
      vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
        col)
      :match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
    mode, true)
end
local cmp = require 'cmp'
cmp.setup({
  snippet = { expand = function(args) vim.fn['vsnip#anonymous'](args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" })
  }),
  sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'vsnip' } },
    { { name = 'buffer' } })
})

-- mason
require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'bash-language-server',
    'dockerfile-language-server',
    'shfmt',
    'json-lsp',
    'pyright',
    'lua-language-server',
    'luaformatter',
    'typescript-language-server',
    'ruff',
    'shellcheck',
    'terraform-ls',
    'vim-language-server',
    'yaml-language-server',
  },
  auto_update = true,
  run_on_start = true,
  debounce_hours = 5,
}

-- lint
require('lint').linters_by_ft = {
  sh = { 'shellcheck' },
  python = { 'ruff' }
}

-- formatter
local lua_format = function()
  return {
    exe = "lua-format",
    args = {
      '--inplace', '--column-limit=100', '--column-table-limit=100',
      '--indent-width=2', '--no-use-tab', '--break-after-operator',
      '--double-quote-to-single-quote'
    },
    stdin = true
  }
end
local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", api.nvim_buf_get_name(0), "--double-quote" },
    stdin = true
  }
end
local ruff = function()
  return { exe = "ruff", args = { "format", "--quiet", "-" }, stdin = true }
end
local shfmt = function()
  return { exe = "shfmt", args = { "-ci", "-s", "-bn" }, stdin = true }
end
local terraform = function()
  return { exe = "terraform", args = { "fmt", "-" }, stdin = true }
end
require("formatter").setup({
  filetype = {
    javascript = { prettier },
    typescript = { prettier },
    html = { prettier },
    lua = { lua_format },
    markdown = { prettier },
    python = { ruff },
    sh = { shfmt },
    terraform = { terraform }
  }
})

-- LSP
local on_attach = function(_, bufnr)
  map('n', '<leader>ef', function() vim.lsp.buf.format { async = true } end,
    { unpack(mapopts), buffer = bufnr, desc = 'Format' })
  map('n', '<leader>eR', vim.lsp.buf.rename,
    { unpack(mapopts), buffer = bufnr, desc = 'Rename file' })
  map('n', '<leader>ea', vim.lsp.buf.code_action,
    { unpack(mapopts), buffer = bufnr, desc = 'Code actions' })
  map('n', '<leader>ld', vim.lsp.buf.definition,
    { unpack(mapopts), buffer = bufnr, desc = 'Definition' })
  map('n', '<leader>lD', vim.lsp.buf.declaration,
    { unpack(mapopts), buffer = bufnr, desc = 'Declaration' })
  map('n', '<leader>lr', builtin.lsp_references,
    { unpack(mapopts), buffer = bufnr, desc = 'References' })
  map('n', '<leader>li', vim.lsp.buf.implementation,
    { unpack(mapopts), buffer = bufnr, desc = 'Implementation' })
  map('n', '<leader>lt', vim.lsp.buf.type_definition,
    { unpack(mapopts), buffer = bufnr, desc = 'Type definition' })
  map('n', '<leader>ls', builtin.lsp_document_symbols,
    { unpack(mapopts), buffer = bufnr, desc = 'Document symbols' })
  map('n', '<leader>lS', builtin.lsp_dynamic_workspace_symbols,
    { unpack(mapopts), buffer = bufnr, desc = 'Workspace symbols' })
  map('n', '<leader>lh', vim.lsp.buf.hover,
    { unpack(mapopts), buffer = bufnr, desc = 'Hover documentation' })
  map('n', '<leader>ly', vim.lsp.buf.signature_help,
    { unpack(mapopts), buffer = bufnr, desc = 'Signature documentation' })
end
require('neodev').setup()
capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
servers = { 'bashls', 'dockerls', 'jsonls', 'pyright', 'lua_ls', 'terraformls', 'tsserver', 'vimls', 'yamlls' }
mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name]
    }
  end
}
require('fidget').setup()

-- dap
require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })

-- which-key
local wk = require("which-key")
wk.register({
  e = '+Edit',
  f = '+Find',
  l = '+LSP',
  p = '+Problems'
}, { prefix = "<leader>" })
