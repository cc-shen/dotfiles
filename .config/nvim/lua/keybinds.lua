-- Leader is ',' see basics.lua
local map = vim.keymap.set

-- Quickly go back to normal mode
map("i", "kj", "<Esc>", { noremap=true })
map("v", "kj", "<Esc>", { noremap=true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Insert blank line below
map('n', '<leader>o', 'o<ESC>')
-- Insert blank line below
map('n', '<leader>O', 'O<ESC>')

-- Move to the previous buffer
map('n', '<leader>[', '<CMD>bp<CR>')
-- Move to the next buffer
map('n', '<leader>]', '<CMD>bn<CR>')

-- Leaderf keybinds
map('n', '<leader>ff', '<CMD>Leaderf file<CR>')
map('n', '<leader>fh', '<CMD>Leaderf help<CR>')
map('n', '<leader>fl', '<CMD>Leaderf line<CR>')
map('n', '<leader>fr', '<CMD>Leaderf mru --absolute-path<CR>')
