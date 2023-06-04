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
vim.cmd.colorscheme 'solarized8_high' -- onedark, solarized8_high
vim.opt_local.background = "light"

-- vim.g.vimtex_view_general_viewer = 'sioyek' -- langer lag bei reload
-- vim.g.vimtex_view_method = 'sioyek'

vim.g.vimtex_quickfix_ignore_filters= {"badness", "Marginpar on page", "too wide", "Foreign command"}
-- require("luasnip.loaders.from_vscode").load({ paths = { "~/.config/Code/User/snippets/" } })

vim.keymap.set({ 'n', 'v'}, '<F7>',    ":call SVED_Sync()<CR>",           { buffer=true })
vim.keymap.set('i', '<F7>',            "<C-c>:call SVED_Sync()<CR>",      { buffer=true })
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

-- print("this was nvim/ftplugin/tex.lua")
