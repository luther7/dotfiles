vim.pack.add({
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/editorconfig/editorconfig-vim" },
  { src = "https://github.com/folke/persistence.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/mzlogin/vim-markdown-toc" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1"),
  },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/williamboman/mason.nvim" },
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("filetype plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd("syntax enable")
end
vim.cmd.colorscheme("catppuccin-mocha")

vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"
vim.o.clipboard = "unnamedplus"
vim.o.colorcolumn = "100"
vim.o.compatible = false
vim.o.cursorline = true
vim.o.encoding = "UTF-8"
vim.o.expandtab = true
vim.o.fileencodings = "UTF-8"
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.linebreak = true
vim.o.list = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.spell = true
vim.o.spelloptions = "camel"
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.swapfile = false
vim.o.switchbuf = "usetab"
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.virtualedit = "block"
vim.o.wb = false
vim.o.winborder = "single"
vim.o.wrap = true
vim.opt_global.completeopt = { "menu", "menuone", "noselect" }
if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
end
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = true,
  update_in_insert = false,
})

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    for k, v in pairs(opts) do
      options[k] = v
    end
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "catppuccin-mocha",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
})

local wk = require("which-key")
wk.setup({ icons = { mappings = false, colors = false }, show_help = false, show_keys = false })
wk.add({
  { "<leader>e", group = "Edit" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "LSP" },
  { "<leader>p", group = "Errors" },
  { "<leader>x", group = "Session" },
})

local actions = require("telescope.actions")
local themes = require("telescope.themes")
require("telescope").setup({
  defaults = {
    mappings = {
      i = { ["<esc>"] = actions.close },
      n = { ["<esc>"] = actions.close, ["q"] = actions.close },
    },
    file_ignore_patterns = { ".git", "node_modules" },
  },
})
pcall(require("telescope").load_extension, "fzf")
local builtin = require("telescope.builtin")
local ivy = function(picker_fn)
  return function()
    picker_fn(themes.get_ivy())
  end
end
map("n", "<leader>b", ivy(builtin.buffers), { desc = "Buffers" })
map("n", "<leader>/", ivy(builtin.live_grep), { desc = "Live grep" })
map("n", "<leader>f", ivy(builtin.find_files), { desc = "Files" })
map("n", "<leader>r", ivy(builtin.oldfiles), { desc = "Recent files" })
map("n", "<leader>h", ivy(builtin.help_tags), { desc = "Help tags" })
map("n", "<leader>es", ivy(builtin.spell_suggest), { desc = "Spell" })

local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = group,
  once = true,
  callback = function()
    require("blink.cmp").setup({
      keymap = {
        preset = "super-tab",
      },
      appearance = {
        nerd_font_variant = "mono",
        use_nvim_cmp_as_default = true,
      },
      completion = {
        documentation = { auto_show = false },
        menu = { draw = { columns = { { "label", "label_description", gap = 1 }, { "kind" } } } },
      },
      sources = {
        default = { "lsp", "path", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    })
  end,
})

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "query",
    "toml",
    "sql",
    "terraform",
    "typescript",
    "yaml",
  },
})

require("mason").setup()
local mason_registry = require("mason-registry")
local ensure_installed = {
  -- language servers
  "dockerfile-language-server",
  "eslint-lsp",
  "lua-language-server",
  "phpactor",
  "psalm",
  "pyright",
  "sqlls",
  "terraform-ls",
  "typescript-language-server",
  "yaml-language-server",
  -- formatters
  "prettier",
  "phpstan",
  "shfmt",
  "shellcheck",
  "stylua",
  "ruff",
  "bash-language-server",
}
for _, tool in ipairs(ensure_installed) do
  if not mason_registry.is_installed(tool) then
    vim.cmd("MasonInstall " .. tool)
  end
end

local on_attach = function(_, bufnr)
  map("n", "grd", vim.lsp.buf.definition, { buffer = bufnr, desc = "vim.lsp.buf.definition()" })
  map("n", "grD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "vim.lsp.buf.declaration()" })
  map("n", "grh", vim.lsp.buf.hover, { buffer = bufnr, desc = "vim.lsp.buf.hover()" })
end
local lsp_servers = {
  "bashls", -- bash-language-server
  "dockerls", -- dockerfile-language-server
  "eslint", -- eslint-lsp
  "lua_ls", -- lua-language-server
  "phpactor", -- phpactor
  "psalm", --psalm
  "pyright", -- pyright
  "sqlls", -- sql-language-server
  "terraformls", -- terraform-language-server
  "ts_ls", -- typescript-language-server
  "yamlls", -- yaml-language-server
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
for _, server in ipairs(lsp_servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
  vim.lsp.enable(server)
end
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      on_attach(client, bufnr)
    end
  end,
})

vim.cmd(
  "highlight! link LspReferenceText CursorColumn | highlight! link LspReferenceRead CursorColumn | highlight! link LspReferenceWrite CursorColumn"
)

require("conform").setup({
  formatters_by_ft = {
    bash = { "shfmt" },
    javascript = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    php = { "prettier" },
    python = { "ruff" },
    sh = { "shfmt" },
    terraform = { "terraform_fmt" },
    typescript = { "prettier" },
    yaml = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
map("n", "<leader>ef", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })

require("trouble").setup({})
map("n", "<leader>pt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>pT", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
map("n", "<leader>ps", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
map("n", "<leader>pl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP" })
map("n", "<leader>pL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
map("n", "<leader>pQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })

require("persistence").setup({
  dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
  need = 2,
})
map("n", "<leader>xr", function()
  require("persistence").load()
end, { desc = "Restore session" })
map("n", "<leader>xl", function()
  require("persistence").load({ last = true })
end, { desc = "Restore last session" })
map("n", "<leader>xd", function()
  require("persistence").stop()
end, { desc = "Don't save session" })

require("oil").setup({
  default_file_explorer = true,
  columns = { "icon" },
  view_options = {
    show_hidden = true,
  },
})
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require("gitsigns").setup({})
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
map("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle blame" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff this" })
map("n", "<leader>gD", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Toggle deleted" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset buffer" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage buffer" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo stage hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
