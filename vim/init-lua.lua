--
-- init.lua
--

local api = vim.api
local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd
local o = vim.o

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--
-- Settings
--
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
cmd('set noshowmode')

vim.opt_global.completeopt = {'menu', 'noinsert', 'noselect'}
vim.opt_global.shortmess:remove('F'):append('c')

if vim.fn.executable 'rg' == 1 then o.grepprg = 'rg --vimgrep --no-heading --smart-case' end

local disabled_built_ins = {
  'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers', 'gzip', 'zip', 'zipPlugin', 'tar',
  'tarPlugin', 'getscript', 'getscriptPlugin', 'vimball', 'vimballPlugin', '2html_plugin',
  'logipat', 'rrhelper', 'spellfile_plugin', 'matchit'
}

for _, plugin in pairs(disabled_built_ins) do vim.g['loaded_' .. plugin] = 0 end

--
-- Theme
--

-- cmd('set t_Co=256')
-- cmd('let g:solarized_termtrans=1')
-- cmd('let g:solarized_termcolors=256')
cmd('let g:solarized_italic=0')
cmd('let g:solarized_bold=0')
cmd('let g:solarized_underline=0')
cmd('let g:lightline = { \'colorscheme\': \'solarized\', }')
cmd('colorscheme solarized')
cmd('set background=light')
cmd('highlight clear SignColumn')
cmd('highlight DiagnosticError guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticWarn guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticInfo guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticHint guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticVirtualTextError guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticVirtualTextWarn guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticVirtualTextInfo guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticVirtualTextHint guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticUnderlineError guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticUnderlineWarn guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticUnderlineInfo guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticUnderlineHint guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticFloatingError guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticFloatingWarn guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticFloatingInfo guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticFloatingHint guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticSignError guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticSignWarn guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticSignInfo guifg=light guibg=NONE guisp=NONE gui=NONE')
cmd('highlight DiagnosticSignHint guifg=light guibg=NONE guisp=NONE gui=NONE')

--
-- LSP
--

local lspconfig = require('lspconfig')

local servers = {
  'bashls', 'dockerls', 'jsonls', 'pyright', 'rnix', 'terraformls', 'tsserver',
  'vimls', 'yamlls'
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {on_attach = on_attach, flags = {debounce_text_changes = 150}}
end

lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = {'json', 'markdown', 'python', 'sh', 'terraform', 'dockerfile', 'lua', 'nix'},
  init_options = {
    filetypes = {sh = 'shellcheck', dockerfile = 'hadolint'},
    formatFiletypes = {
      json = 'prettier',
      markdown = 'prettier',
      python = 'black',
      terraform = 'terraform',
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
      },
      hadolint = {
        command = 'hadolint',
        sourceName = 'hadolint',
        args = {'-f', 'json', '-'},
        parseJson = {
          line = 'line',
          colume = 'column',
          security = 'level',
          message = '${message} [${code}]'
        },
        securities = {error = 'error', warning = 'warning', info = 'info', style = 'hint'}
      }
    },
    formatters = {
      black = {command = 'black', args = {'--quiet', '-'}},
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

vim.cmd([[hi! link LspReferenceText CursorColumn]])
vim.cmd([[hi! link LspReferenceRead CursorColumn]])
vim.cmd([[hi! link LspReferenceWrite CursorColumn]])

vim.diagnostic.config({
	virtual_text = { source = "always", prefix = "●" },
	float = { source = "always" },
	underline = true,
})

--
-- Treesitter
--

require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {enable = true, disable = {}},
  indent = {enable = false, disable = {}}
}

--
-- Compe
--

require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
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

local t = function(str) return api.nvim_replace_termcodes(str, true, true, true) end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t '<Plug>(vsnip-expand-or-jump)'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t '<Plug>(vsnip-jump-prev)'
  else
    return t '<S-Tab>'
  end
end

--
-- Telescope
--

local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {['<esc>'] = actions.close},
      n = {['<esc>'] = actions.close, ['q'] = actions.close}
    },
    file_ignore_patterns = {'.git', 'node_modules', '%.png', 'h.jpg', '%.jpeg'},
    theme = 'get_dropdown',
    layout_strategy = 'flex'
  }
}

--
-- Trouble
--

require("trouble").setup {
  icons = false
}

--
-- Mappings
--

map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('i', '<CR>', 'compe#confirm("\\<CR>")', {expr = true})

map('n', '<F1>', '<CMD>Telescope buffers previewer=false <CR>', {noremap = true})
map('n', '<F2>', '<CMD>Telescope find_files hidden=true previewer=false <CR>', {noremap = true})
map('n', '<F3>', '<CMD>Telescope live_grep previewer=false <CR>', {noremap = true})
map('n', '<F4>', '<CMD>Telescope grep_string previewer=false <CR>', {noremap = true})
-- map('n', '<F5>', '<CMD><CR>', {noremap = true})
map('n', '<F6>', '<CMD>Telescope command_history <CR>', {noremap = true})
map('n', '<F7>', '<CMD>Telescope spell_suggest <CR>', {noremap = true})
map('n', '<F8>', '<CMD>TroubleToggle <CR>', {noremap = true})
-- map('n', '<F9>', '<CMD> <CR>', {noremap = true})
map('n', '<F10>', '<CMD>lua vim.lsp.buf.formatting() <CR>', {noremap = true})
