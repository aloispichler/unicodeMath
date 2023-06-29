--[[

gist: https://gist.github.com/aloispichler/9c0650fce17af172c36f7e8885c621c7

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to rkead through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

--]]

-- Set \ or <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
-- Install package manager. Runc :Lazy to install or update new packages
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  --  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },  -- open by typing <Space>
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
      --  theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

--  { -- Add indentation guides even on blank lines
--    'lukas-reineke/indent-blankline.nvim',
--    -- Enable `lukas-reineke/indent-blankline.nvim`
--    -- See `:help indent_blankline.txt`
--    opts = {
--      char = '┊',
--      show_trailing_blankline_indent = false,
--    },
--  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  { 'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
-- Alois
  { -- Scrollbar
    'dstein64/nvim-scrollview'
  },

  { -- tree
    'nvim-tree/nvim-tree.lua'
  },

  { -- tree, icons
    'nvim-tree/nvim-web-devicons'
  },

  { -- fzf
    'junegunn/fzf.vim'
  },

  { -- fzf
    'junegunn/fzf'
  },
  { -- autoclose
    'm4xshen/autoclose.nvim'
  },

  { -- easymotion: default keymaps: \\, as \\e, \\b, \\w
    'easymotion/vim-easymotion'
  },

  { -- vimtex: default keymaps: \l, as \ll, etc.
    'lervag/vimtex'
  },

  { -- vimtex-evince forward search, see ./ftplugin/tex.lua
    -- requires: pip install pynvim – see requirements on https://github.com/peterbjorgensen/sved
    'peterbjorgensen/sved'
  },
--
--  { -- code completion
--    'neoclide/coc.nvim'
--  },

  { -- send code to the REPL -- Ctrl-C  to setup; run with Julia
    'jpalardy/vim-slime'
  },
--
--  {-- Julia
--    'JuliaEditorSupport/julia-vim'
--  },
--
--  {-- collection of common configurations for the nvim LSP client
--    'neovim/nvim-lsp'
--  },
--
--  {-- Julia
--    'fannheyward/coc-julia'
--  },

  { -- colorscheme
    'folke/tokyonight.nvim'
  },

  { -- colorscheme
    'sainnhe/gruvbox-material'
  },

  {
    'ellisonleao/gruvbox.nvim'
  },

  { -- colorscheme
    'ellisonleao/gruvbox.nvim'
  },

  { -- solarizde8 colorscheme
    'lifepillar/vim-solarized8'
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  --  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'
vim.o.scrolloff = 3
vim.o.shiftwidth= 3
vim.o.linebreak = true
vim.o.smartindent = true


-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'number'    -- Alois. proposed here 'yes' , 'auto'

-- Decrease update time
-- vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.whichwrap= "b,s,<,>,],["  -- the characters which wrap
vim.opt.termguicolors = true  -- for nvim-tree and others
vim.g.loaded_netrw= 1         -- for nvim-tree
vim.g.loaded_netrwPlugin= 1   -- for nvim-tree

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set({'n', 'v'}, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, '<Down>', "v:count == 0 ? 'gj' : '<Down>'", { expr = true, silent = true })
vim.keymap.set('i', '<Down>', "v:count == 0 ? '<C-o>gj' : '<Down>'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, '<Up>', "v:count == 0 ? 'gk' : '<Up>'", { expr = true, silent = true })
vim.keymap.set('i', '<Up>', "v:count == 0 ? '<C-o>gk' : '<Up>'", { expr = true, silent = true })

-- Keymaps Alois: type <space><bs> to see the remappings.
-- vim.keymap.set({'n', 'v'}, 'e',    'el', {})
-- vim.keymap.set({'n', 'v'}, 'E',    'El', {})
vim.keymap.set({'n', 'v'}, 'E',    'El', {})
vim.keymap.set({'n', 'v'}, 'B',    'Bh', {})
vim.keymap.set({'n', 'v', 'i'}, '<A-Right>',    '<Esc>g$', {})
vim.keymap.set({'n', 'v', 'i'}, '<A-Left>',    '<Esc>g0', {})
vim.keymap.set('i', 'jj',    '<Esc>l', {})
vim.keymap.set('i', '<A-i>', '<Esc>l', {})
vim.keymap.set({'n', 'v'},   'J', '<PageDown>', {})
vim.keymap.set({'n', 'v'},   'K', '<PageUp>', {})
vim.keymap.set({'n', 'v'},   '<C-j>', '<C-e>g<Down>', {})
vim.keymap.set( 'i',         '<C-j>', '<Esc>l', {})
vim.keymap.set({'n', 'v'},   '<A-j>', '<C-e>', {})
vim.keymap.set( 'i',         '<A-j>', '<Esc>l', {})
vim.keymap.set( 'i',         '<A-d>', '<Esc>l', {})
vim.keymap.set( 'n',         '<C-h>', '<C-Left>', {})
vim.keymap.set( 'v',         '<C-h>', '<C-Left>h', {})
vim.keymap.set( 'i',         '<C-h>', '<Right><Esc><C-Left>', {})
vim.keymap.set({'v', 'n'},   '<A-h>', 'g0', {})
vim.keymap.set( 'i',         '<A-h>', '<Esc>', {})
vim.keymap.set({'v', 'n'},   '<A-l>', 'g$', {})
vim.keymap.set({'n', 'v'},   '<C-b>', '<C-Left>', {})
vim.keymap.set( 'i',         '<C-b>', '<Right><Esc><C-Left>', {})
vim.keymap.set({'n', 'v'},   '<C-k>', '<C-y>g<Up>', {})
vim.keymap.set( 'i',         '<C-k>', '<Esc>l', {})
vim.keymap.set({'n', 'v'},   '<A-k>', '<C-y>', {})
vim.keymap.set( 'i',         '<A-k>', '<Esc><C-y>', {})
vim.keymap.set( 'n',         '<C-l>', '<Right><C-Right>', {})
vim.keymap.set( 'v',         '<C-l>', '<Right><C-Right>h', {})
vim.keymap.set( 'i',         '<C-l>', '<Esc>l<C-Right>', {})
vim.keymap.set({'n', 'v'},   '<C-e>', '<C-Right>', {})
vim.keymap.set( 'i',         '<C-e>', '<Esc>l<C-Right>', {})
vim.keymap.set({'n', 'v'},      '<C-s>', ':write<CR>', {})
vim.keymap.set( 'i',            '<C-s>', '<Esc>l:write<CR>', {})
vim.keymap.set({'n', 'i', 'v'}, '<C-Tab>',   '<Esc>gt')
vim.keymap.set({'n', 'i', 'v'}, '<C-S-Tab>', '<Esc>gT')
-- display highlight settings at cursor position.
vim.keymap.set('n', '<F2>', ':echo "hi<" .synIDattr(synID(line("."),col("."),1),"name") . "> trans<" . synIDattr(synID(line("."),col("."),0),"name") ."> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") .">"<CR>', {})
vim.keymap.set({'n', 'i', 'v'}, '<C-F>', '<Esc>:call fzf#run({"sink": "tabedit"})<CR>', {})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Alois: return to normal mode on focus lost
vim.o.spelllang= "en_us,de_20"  -- load spellfile as sudo
vim.o.spell = true
vim.o.cursorline = true
-- Alois: return to normal mode on focus lost
vim.api.nvim_create_autocmd("FocusLost", { pattern = "*", command = [[call feedkeys("\<esc>")]] })
-- vim.api.nvim_create_autocmd({"WinEnter", "Focuslost"},   { pattern = "*", command = [[setlocal nocursorline]] })
-- vim.api.nvim_create_autocmd({"WinEnter", "FocusGained"}, { pattern = "*", command = [[setlocal cursorline]] })
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- nvim tree, Alois
require("nvim-tree").setup()
vim.keymap.set({'n', 'v'},   '<F3>', ':NvimTreeToggle %:h<CR>', {})

-- luasnips: Alois
require("luasnip/loaders/from_vscode").lazy_load({paths='~/.config/nvim/snippets'})

-- Scrollbar: Alois
require('scrollview').setup({
  excluded_filetypes = {'nerdtree'},
  current_only = true,
--  winblend = 75,
--  base = 'buffer',
--  column = 80,
})

-- autoclose, autopair: Alois
require("autoclose").setup({
  keys = {
      ["$"] = { escape = true, close = true, pair = "$$"},
      ["["] = { escape = false, close = false, pair = "[]"},
   },
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<space>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<space><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<space>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'julia', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true , disable= {'latex'}}, -- Alois: disable for tex
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.
-- 	│	run :Lsp… (ie., :Lsp<Tab>, for example :LspInstall) to un/install the language server
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help H` for why this keymap
  nmap('H', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<F1>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- luasnip
local luasnip = require 'luasnip'
luasnip.config.setup({
  store_selection_keys=  '<Tab>', -- the key to select for TM_SELECTED_TEXT
  --history= true,
    -- those are for removing deleted snippets, also a common problem
  --updateevents= "TextChanged,TextchangedI",
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave", --,InsertEnter",
})
-- local ls= require("luasnip")
-- local t= ls.text_node
-- local s= ls.snippet
-- ls.setup_snip_env()
-- ls.add_snippets("all", {s("_pm", {t"±"})}, {key = "asdf"})-- local s=ls.snippet

-- nvim-cmp setup (dropdowns)
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {  -- <TAB>
      -- behavior = cmp.ConfirmBehavior.Replace,  -- if active, replaces succeeding text
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
