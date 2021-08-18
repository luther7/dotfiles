--
-- init.lua
--

local api = vim.api
local execute = vim.api.nvim_command
local map = vim.api.nvim_set_keymap
local fn = vim.fn
local cmd = vim.cmd
local o = vim.o

--
-- Settings
--

cmd("syntax on")
cmd("filetype plugin indent on")

o.compatible = false
o.encoding = "UTF-8"
o.fileencodings = "UTF-8"
o.number = true
o.wrap = true
o.signcolumn = "yes"
o.cursorline = true
o.colorcolumn = "100"
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.swapfile = false
o.wb = false
o.spell = true
o.clipboard = "unnamedplus"

if vim.fn.executable "rg" == 1 then
  o.grepprg = "rg --vimgrep --no-heading --smart-case"
end

local disabled_built_ins = {
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip", "zip",
  "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin", "vimball",
  "vimballPlugin", "2html_plugin", "logipat", "rrhelper", "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do vim.g["loaded_" .. plugin] = 0 end

--
-- Packer
--

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path
  })
  execute "packadd packer.nvim"
end

cmd("packadd packer.nvim")

require("packer").startup(function()
  use "airblade/vim-rooter"
  use "altercation/vim-colors-solarized"
  use "b3nj5m1n/kommentary"
  use "christoomey/vim-tmux-navigator"
  use "hashivim/vim-terraform"
  use "hrsh7th/nvim-compe"
  use "hrsh7th/vim-vsnip"
  use "itchyny/lightline.vim"
  use "mzlogin/vim-markdown-toc"
  use "neovim/nvim-lspconfig"
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "nvim-lua/completion-nvim"
  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}
  }
  use "tsandall/vim-rego"
  use "wbthomason/packer.nvim"
end)

--
-- Theme
--

o.background = "light"

cmd("colo solarized")
cmd("hi clear SignColumn")

vim.g.solarized_visibility = "high"
vim.g.solarized_contrast = "high"

cmd("let g:lightline = { 'colorscheme': 'solarized', }")

--
-- LSP
--

local lspconfig = require("lspconfig")

local servers = {
  "bashls", "dockerls", "jsonls", "pyright", "solargraph", "terraformls",
  "tsserver", "vimls", "yamlls"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
  }
end

lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = {
    "json", "markdown", "python", "sh", "terraform", "dockerfile", "lua"
  },
  init_options = {
    filetypes = {python = "flake8", sh = "shellcheck", dockerfile = "hadolint"},
    formatFiletypes = {
      json = "prettier",
      markdown = "prettier",
      python = "black",
      terraform = "terraform",
      yaml = "prettier",
      lua = "luaformat"
    },
    linters = {
      flake8 = {
        command = "flake8",
        debounce = 100,
        args = {"--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s", "-"},
        offsetLine = 0,
        offsetColumn = 0,
        formatLines = 1,
        formatPattern = {
          "(\\d+),(\\d+),({A-Z}),(.*)(\\r|\\n)*$",
          {line = 1, column = 2, security = 3, message = 4}
        },
        securities = {
          W = "warning",
          E = "error",
          F = "error",
          C = "error",
          N = "error"
        }
      },
      shellcheck = {
        sourceName = "shellcheck",
        command = "shellcheck",
        args = {"--format", "json", "-"},
        debounce = 100,
        parseJson = {
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} { ${code} }",
          security = "level"
        },
        securities = {
          error = "error",
          warning = "warning",
          info = "info",
          style = "hint"
        }
      },
      hadolint = {
        command = "hadolint",
        sourceName = "hadolint",
        args = {"-f", "json", "-"},
        parseJson = {
          line = "line",
          colume = "column",
          security = "level",
          message = "${message} [${code}]"
        },
        securities = {
          error = "error",
          warning = "warning",
          info = "info",
          style = "hint"
        }
      }
    },
    formatters = {
      black = {command = "black", args = {"--quiet", "-"}},
      prettier = {
        command = "prettier",
        args = {"--stdin-filepath", "%filepath"}
      },
      terraform = {command = "terraform", args = {"fmt", "-"}},
      luaformat = {
        command = "lua-format",
        args = {
          "-i", "--column-limit=100", "--column-table-limit=80",
          "--indent-width=2", "--no-use-tab", "--break-after-operator"
        }
      }
    }
  }
}

--
-- Treesitter
--

require"nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  highlight = {enable = true, disable = {}},
  indent = {enable = false, disable = {}}
}

--
-- Compe
--

require"compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    treesitter = true,
    vsnip = true,
    ultisnips = true,
    luasnip = true
  }
}

local t =
    function(str) return api.nvim_replace_termcodes(str, true, true, true) end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn["vsnip#available"](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

--
-- Telescope
--

local actions = require("telescope.actions")

require("telescope").setup {
  defaults = {
    mappings = {
      i = {["<esc>"] = actions.close},
      n = {["<esc>"] = actions.close}
    }
  }
}

--
-- Mappings
--

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

map("n", "<F1>", ":Telescope buffers<CR>", {noremap = true})
map("n", "<F2>", ":Telescope find_files<CR>", {noremap = true})
map("n", "<F3>", ":Telescope file_browser<CR>", {noremap = true})
map("n", "<F4>", ":Telescope live_grep<CR>", {noremap = true})
map("n", "<F5>", ":Telescope grep_string<CR>", {noremap = true})
map("n", "<F6>", ":Telescope lsp_definitions<CR>", {noremap = true})
-- map("n", "<F7>", "", {noremap = true})
-- map("n", "<F8>", "", {noremap = true})
map("n", "<F9>", ":Telescope lsp_code_actions", {noremap = true, silent = true})
map("n", "<F10>", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap = true})
