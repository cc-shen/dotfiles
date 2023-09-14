-- No netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- No tohtml.vim
vim.g.loaded_2html_plugin = 1
-- No plugins to check compressed files
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

require('plugins')
require('basics')
require('keybinds')
