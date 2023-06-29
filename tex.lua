-- ~/.config/nvim/ftplugin/tex.lua
-- print("this is nvim/ftplugin/tex.lua")
-- 	╭─────────────────────────────────────────────────────
-- 	│	run :Lsp…  (for example :LspInstall) to un/install the language server

-- 	╭─────────────────────────────────────────────────────
-- 	│	local settings for LaTeXvim.opt_local.shiftwidth = 4
vim.opt_local.shiftwidth= 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = false
vim.o.spell = false	-- run LSP and install ltex instead
vim.wo.wrap= true
-- vim.cmd.colorscheme 'gruvbox' -- solarized8_high, onedark, solarized8_high
vim.cmd.colorscheme 'gruvbox-material' -- solarized8_high, onedark, solarized8_high
vim.opt_local.background = "light"
vim.g.scrollview_signs_on_startup= {'search'}		-- global variable to disable diagnostics
-- vim.g.vimtex_view_general_viewer = 'sioyek' -- langer lag bei reload
-- vim.g.vimtex_view_method = 'sioyek'

vim.g.vimtex_quickfix_ignore_filters= {"badness", "Marginpar on page", "too wide", "Foreign command"}
-- require("luasnip.loaders.from_vscode").load({ paths = { "~/.config/Code/User/snippets/" } })

vim.keymap.set({ 'i'},      '<F6>', "<C-O>:w<CR>",            { buffer=true })
vim.keymap.set({ 'n', 'v'}, '<F6>', "<Right><Esc>:w<CR>",            { buffer=true })
vim.keymap.set({ 'n', 'v'}, '<F7>',    ":call SVED_Sync()<CR>",           { buffer=true })
vim.keymap.set('i',         '<F7>',            "<C-c>:call SVED_Sync()<CR>",      { buffer=true })
vim.keymap.set({'n', 'v'},      '<S-CR>', ':write<CR>', { buffer= true})
vim.keymap.set( 'i',            '<S-CR>', '<Esc>l:write<CR>', { buffer= true})
vim.keymap.set('n', '<localleader>lc', ":VimtexStop<CR>:VimtexClean<CR>", { buffer=true })

vim.opt.iskeyword:append("\\")
vim.opt.matchpairs:append("❪:❫,⟮:⟯,❨:❩")
-- vim.opt.matchpairs= {"❪:❫", "⟮:⟯", "❨:❩", "(:)", "{:}", "[:]", "<:>"}


-- nvim-cmp setup
require('cmp').setup{	-- reset cmp
  sources = {
    { name = 'luasnip' },	-- enable LSP-autocompletion for Luasnips
--  { name = 'nvim_lsp' },  	-- disable LSP-autocompletion for LaTeX
  },
}

local lspconfig = require('lspconfig')
lspconfig.ltex.setup({
   -- enabled= true,
   settings = {
      ltex = {
	ltex = { dictionary = { ["en-us"] = { "🔖prop", "🔖rem", "Borel", "Chernoff", "equivariance", "extremal", "Fubini", "Hadamard", "infimum", "Kullback", "Leibler", "Nikodým", "Pichler", "Rajmadan", "Lakshmanan", "quantizers", "summand", "Sinkhorn", "softmin", "Technische", "Universität", "Wasserstein" }}, language = "en-us" },
   }},
   })
-- local lspconfig = require('lspconfig')
--    lspconfig.texlab.setup({
--       setting= {
-- 	 texlab= {
-- 	    forwardSearch = {
-- 	       executable = 'sioyek',
-- 	       args= {
--     '--reuse-window',
--     '--execute-command', 'toggle_synctex', -- Open Sioyek in synctex mode.
--     '--inverse-search',
--     [[nvim-texlabconfig -file %%%1 -line %%%2 -server ]] .. vim.v.servername,
--     '--forward-search-file', '%f',
--     '--forward-search-line', '%l', '%p'
-- }}}},
--     --  forwardSearch = {
--     --            executable = "sioyek",
--     --            args = { '--reuse-window',
--     -- '--execute-command', 'toggle_synctex', -- Open Sioyek in synctex mode.
--     -- '--inverse-search',
--     -- [[nvim-texlabconfig -file %%%1 -line %%%2 -server ]] .. vim.v.servername,
--     -- '--forward-search-file', '%f',
--     -- '--forward-search-line', '%l', '%p' },
--    	--     onSave= true
--     --        },
--     --  -- forwardSearch = {
--     --  --           executable = "zathura",
--     --  --           args = { "--synctex-forward", "%l:1:%f", "%p" }
--     --  --       },
--    })

-- print("this was nvim/ftplugin/tex.lua")
