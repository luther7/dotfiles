-- Plugins
vim.pack.add({
  {src = 'https://github.com/catppuccin/nvim'},
  {src = 'https://github.com/christoomey/vim-tmux-navigator'},
  {src = 'https://github.com/editorconfig/editorconfig-vim'},
  {src = 'https://github.com/folke/which-key.nvim'},
  {src = 'https://github.com/folke/trouble.nvim'}, {src = 'https://github.com/hrsh7th/nvim-cmp'},
  {src = 'https://github.com/hrsh7th/cmp-nvim-lsp'},
  {src = 'https://github.com/hrsh7th/cmp-buffer'}, {src = 'https://github.com/hrsh7th/cmp-cmdline'},
  {src = 'https://github.com/hrsh7th/cmp-nvim-lua'}, {src = 'https://github.com/hrsh7th/cmp-path'},
  {src = 'https://github.com/lewis6991/gitsigns.nvim'},
  {src = 'https://github.com/phpactor/phpactor'},
  {src = 'https://github.com/mzlogin/vim-markdown-toc'},
  {src = 'https://github.com/neovim/nvim-lspconfig'},
  {src = 'https://github.com/williamboman/mason.nvim'},
  {src = 'https://github.com/williamboman/mason-lspconfig.nvim'},
  {src = 'https://github.com/stevearc/conform.nvim'},
  {src = 'https://github.com/nvim-treesitter/nvim-treesitter'},
  {src = 'https://github.com/nvim-lua/plenary.nvim'},
  {src = 'https://github.com/nvim-telescope/telescope.nvim'},
  {src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'},
  {src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'},
  {src = 'https://github.com/nvim-lualine/lualine.nvim'},
  {src = 'https://github.com/mfussenegger/nvim-dap'},
  {src = 'https://github.com/rcarriga/nvim-dap-ui'},
  {src = 'https://github.com/jay-babu/mason-nvim-dap.nvim'},
  {src = 'https://github.com/nvim-neotest/neotest'},
  {src = 'https://github.com/haydenmeade/neotest-jest'},
  {src = 'https://github.com/olimorris/neotest-phpunit'},
  {src = 'https://github.com/nvim-neotest/nvim-nio'}
})

-- Settings
vim.o.compatible = false
vim.o.encoding = 'UTF-8'
vim.o.fileencodings = 'UTF-8'
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.colorcolumn = '100'
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.o.wb = false
vim.o.spell = true
vim.o.clipboard = 'unnamedplus'
vim.o.termguicolors = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.opt_global.completeopt = {'menu', 'menuone', 'noselect'}
if vim.fn.executable 'rg' == 1 then vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case' end
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd.colorscheme 'catppuccin-mocha'

-- Helper for keymaps
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then for k, v in pairs(opts) do options[k] = v end end
  vim.keymap.set(mode, lhs, rhs, options)
end

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
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash', 'javascript', 'lua', 'markdown', 'markdown_inline', 'php', 'python', 'query', 'toml',
    'sql', 'terraform', 'typescript', 'yaml'
  },
  sync_install = false,
  auto_install = true,
  highlight = {enable = true, additional_vim_regex_highlighting = false},
  indent = {enable = true}
}

-- telescope
local actions = require('telescope.actions')
local themes = require('telescope.themes')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {['<esc>'] = actions.close},
      n = {['<esc>'] = actions.close, ['q'] = actions.close}
    },
    file_ignore_patterns = {'.git', 'node_modules'}
  }
}
pcall(require('telescope').load_extension, 'fzf')
local builtin = require('telescope.builtin')
local ivy = function(picker_fn) return function() picker_fn(themes.get_ivy()) end end
map('n', '<leader>b', ivy(builtin.buffers), {desc = 'Buffers'})
map('n', '<leader>g', ivy(builtin.live_grep), {desc = 'Live grep'})
map('n', '<leader>f', ivy(builtin.find_files), {desc = 'Files'})
map('n', '<leader>r', ivy(builtin.oldfiles), {desc = 'Recent files'})
map('n', '<leader>h', ivy(builtin.help_tags), {desc = 'Help tags'})
map('n', '<leader>es', ivy(builtin.spell_suggest), {desc = 'Spell'})
map('n', '<leader>lr', ivy(builtin.lsp_references), {desc = 'LSP References'})
map('n', '<leader>ld', ivy(builtin.lsp_definitions), {desc = 'LSP Definitions'})
map('n', '<leader>lt', ivy(builtin.lsp_type_definitions), {desc = 'LSP Type Definitions'})
map('n', '<leader>li', ivy(builtin.lsp_implementations), {desc = 'LSP Implementations'})
map('n', '<leader>ls', ivy(builtin.lsp_document_symbols), {desc = 'LSP Document Symbols'})
map('n', '<leader>lw', ivy(builtin.lsp_workspace_symbols), {desc = 'LSP Workspace Symbols'})
map('n', '<leader>la', ivy(builtin.diagnostics), {desc = 'LSP Diagnostics'})

-- cmp
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
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
  map('n', 'grd', vim.lsp.buf.definition, {buffer = bufnr, desc = 'Go to definition'})
  map('n', 'grD', vim.lsp.buf.declaration, {buffer = bufnr, desc = 'Go to declaration'})
  map('n', 'grh', vim.lsp.buf.hover, {buffer = bufnr, desc = 'Hover documentation'})
end
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                                                                    .make_client_capabilities())

-- mason
require('mason').setup()
local lspservers = {'bashls', 'jsonls', 'pyright', 'terraformls', 'lua_ls', 'yamlls'}
require('mason-lspconfig').setup {
  ensure_installed = lspservers,
  automatic_installation = true,
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup {on_attach = on_attach, capabilities = capabilities}
    end
  }
}

-- PHP and TypeScript LSPs (not available via mason)
vim.lsp.config('phan', {on_attach = on_attach, capabilities = capabilities})
vim.lsp.enable('phan')
vim.lsp.config('phpactor', {on_attach = on_attach, capabilities = capabilities})
vim.lsp.enable('phpactor')
vim.lsp.config('ts_ls', {on_attach = on_attach, capabilities = capabilities})
vim.lsp.enable('ts_ls')

-- conform
require('conform').setup {
  formatters_by_ft = {
    lua = {'stylua'},
    javascript = {'prettier'},
    typescript = {'prettier'},
    json = {'prettier'},
    yaml = {'prettier'},
    markdown = {'prettier'},
    python = {'ruff'},
    terraform = {'terraform_fmt'},
    sh = {'shfmt'}
  },
  format_on_save = {timeout_ms = 500, lsp_fallback = true}
}
map('n', '<leader>ef', function() require('conform').format {async = true, lsp_fallback = true} end,
    {desc = 'Format'})
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = true,
  update_in_insert = false
})
vim.cmd(
  'highlight! link LspReferenceText CursorColumn | highlight! link LspReferenceRead CursorColumn | highlight! link LspReferenceWrite CursorColumn')

-- trouble
require('trouble').setup {}

-- DAP
local dap = require('dap')
local dapui = require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
require('mason-nvim-dap').setup {
  ensure_installed = {'js-debug-adapter', 'php-debug-adapter'},
  automatic_installation = true,
  handlers = {}
}
local js_debug_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter'
pcall(function()
  local mason_registry = require('mason-registry')
  if mason_registry.is_installed('js-debug-adapter') then
    js_debug_path = mason_registry.get_package('js-debug-adapter'):get_install_path()
  end
end)
dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {js_debug_path .. '/js-debug/src/dapDebugServer.js', '${port}'}
  }
}
dap.configurations.typescript = {
  {
    type = 'pwa-node',
    request = 'attach',
    name = 'Attach',
    processId = require('dap.utils').pick_process,
    cwd = '${workspaceFolder}',
    skipFiles = {'<node_internals>/**'},
    resolveSourceMapLocations = {'${workspaceFolder}/**', '!**/node_modules/**'}
  }
}
dap.configurations.javascript = dap.configurations.typescript
local php_debug_path = vim.fn.stdpath('data') .. '/mason/packages/php-debug-adapter'
pcall(function()
  local mason_registry = require('mason-registry')
  if mason_registry.is_installed('php-debug-adapter') then
    php_debug_path = mason_registry.get_package('php-debug-adapter'):get_install_path()
  end
end)
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {php_debug_path .. '/extension/out/phpDebug.js'}
}
dap.configurations.php = {
  {type = 'php', request = 'launch', name = 'Listen for Xdebug', port = 9003}
}
map('n', '<leader>db', dap.toggle_breakpoint, {desc = 'Toggle Breakpoint'})
map('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    {desc = 'Set Conditional Breakpoint'})
map('n', '<leader>dl',
    function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    {desc = 'Set Logpoint'})
map('n', '<leader>dc', dap.continue, {desc = 'Continue'})
map('n', '<leader>di', dap.step_into, {desc = 'Step Into'})
map('n', '<leader>do', dap.step_over, {desc = 'Step Over'})
map('n', '<leader>dO', dap.step_out, {desc = 'Step Out'})
map('n', '<leader>dr', dap.restart, {desc = 'Restart'})
map('n', '<leader>dt', dap.terminate, {desc = 'Terminate'})
map('n', '<leader>du', dapui.toggle, {desc = 'Toggle UI'})
map('n', '<leader>de', dapui.eval, {desc = 'Evaluate'})
map('n', '<leader>dE', function() dapui.eval(vim.fn.input('Expression: ')) end,
    {desc = 'Evaluate Expression'})

-- neotest
local neotest = require('neotest')
local neotest_jest = require('neotest-jest')
local neotest_phpunit = require('neotest-phpunit')
neotest.setup {
  adapters = {
    neotest_jest({
      jestCommand = function()
        local package_json = vim.fn.findfile('package.json', '.;')
        if package_json ~= '' then
          local package_json_path = vim.fn.fnamemodify(package_json, ':p')
          local package_dir = vim.fn.fnamemodify(package_json_path, ':h')
          local yarn_lock = vim.fn.findfile('yarn.lock', package_dir .. ';')
          if yarn_lock ~= '' then return 'yarn test --' end
          return 'npm test --'
        end
        return 'jest'
      end,
      jestArguments = function(defaultArguments, context)
        local file_path = context.file
        if file_path then
          local filename = vim.fn.fnamemodify(file_path, ':t')
          if string.match(filename, '%.e2e%-spec%.ts$') then
            return vim.list_extend(defaultArguments, {'--config', './jest-e2e.config.ts'})
          elseif string.match(filename, '%.test%.ts$') then
            return vim.list_extend(defaultArguments, {'--config', './jest-integration.config.ts'})
          end
        end
        return defaultArguments
      end,
      jestConfigFile = function()
        local config_files = {
          'jest.config.ts', 'jest.config.js', 'jest.config.mjs', 'jest.config.cjs',
          'jest.config.json'
        }
        for _, file in ipairs(config_files) do
          local found = vim.fn.findfile(file, '.;')
          if found ~= '' and vim.fn.filereadable(found) == 1 then return found end
        end
        return nil
      end,
      cwd = function(path) return vim.fn.getcwd() end,
      isTestFile = require("neotest-jest.jest-util").defaultIsTestFile
    }), neotest_phpunit({
      phpunit_cmd = function()
        local vendor_phpunit = 'vendor/bin/phpunit'
        if vim.fn.executable(vendor_phpunit) == 1 then return vendor_phpunit end
        return 'phpunit'
      end
    })
  }
}
map('n', '<leader>tn', function() neotest.run.run() end, {desc = 'Run nearest test'})
map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end,
    {desc = 'Run current file'})
map('n', '<leader>td', function() neotest.run.run({strategy = 'dap'}) end,
    {desc = 'Debug nearest test'})
map('n', '<leader>ts', function() neotest.summary.toggle() end, {desc = 'Toggle summary'})
map('n', '<leader>to', function() neotest.output.open({enter = true}) end, {desc = 'Open output'})
map('n', '<leader>tp', function() neotest.output_panel.toggle() end, {desc = 'Toggle output panel'})
map('n', '<leader>tS', function() neotest.run.stop() end, {desc = 'Stop test'})

-- which-key
local wk = require('which-key')
wk.setup {icons = {mappings = false, colors = false}, show_help = false, show_keys = false}
wk.add({
  {'<leader>e', group = 'Edit'}, {'<leader>l', group = 'LSP'}, {'<leader>m', group = 'Marks'},
  {'<leader>p', group = 'Trouble'}, {'<leader>d', group = 'Debug'}, {'<leader>t', group = 'Tests'},
  {'<leader>pt', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)'}, {
    '<leader>pT',
    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    desc = 'Buffer Diagnostics (Trouble)'
  }, {'<leader>ps', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)'}, {
    '<leader>pl',
    '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
    desc = 'LSP Definitions / references / ... (Trouble)'
  }, {'<leader>pL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)'},
  {'<leader>pQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)'},
  {'<leader>tn', function() require('neotest').run.run() end, desc = 'Run nearest test'}, {
    '<leader>tf',
    function() require('neotest').run.run(vim.fn.expand('%')) end,
    desc = 'Run current file'
  }, {
    '<leader>td',
    function() require('neotest').run.run({strategy = 'dap'}) end,
    desc = 'Debug nearest test'
  }, {'<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle summary'},
  {
    '<leader>to',
    function() require('neotest').output.open({enter = true}) end,
    desc = 'Open output'
  }, {
    '<leader>tp',
    function() require('neotest').output_panel.toggle() end,
    desc = 'Toggle output panel'
  }, {'<leader>tS', function() require('neotest').run.stop() end, desc = 'Stop test'},
  {'<leader>ml', ivy(builtin.marks), desc = 'List all marks'}, {
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
  {'<leader>mG', '<cmd>delmarks A-Z<cr>', desc = 'Delete all global marks'},
  {'<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint'}, {
    '<leader>dB',
    function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    desc = 'Set Conditional Breakpoint'
  }, {
    '<leader>dl',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    desc = 'Set Logpoint'
  }, {'<leader>dc', function() require('dap').continue() end, desc = 'Continue'},
  {'<leader>di', function() require('dap').step_into() end, desc = 'Step Into'},
  {'<leader>do', function() require('dap').step_over() end, desc = 'Step Over'},
  {'<leader>dO', function() require('dap').step_out() end, desc = 'Step Out'},
  {'<leader>dr', function() require('dap').restart() end, desc = 'Restart'},
  {'<leader>dt', function() require('dap').terminate() end, desc = 'Terminate'},
  {'<leader>du', function() require('dapui').toggle() end, desc = 'Toggle UI'},
  {'<leader>de', function() require('dapui').eval() end, desc = 'Evaluate'}, {
    '<leader>dE',
    function() require('dapui').eval(vim.fn.input('Expression: ')) end,
    desc = 'Evaluate Expression'
  }
})
