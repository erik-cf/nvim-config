vim.opt.termguicolors = true
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_foreground = 'material'
require("erikc.remap")
require("erikc.config.lazy")
require("erikc.set")
vim.cmd('colorscheme gruvbox-material')
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

require'nvim-treesitter'.install { 'go', 'typescript' }

