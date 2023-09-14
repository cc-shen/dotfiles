-- Leader is ',' see basics.lua
local map = vim.keymap.set

-- Quickly go back to normal mode
map('i', 'kj', '<Esc>', { noremap = true })
map('v', 'kj', '<Esc>', { noremap = true })

-- Moving within insert mode
map('i', '<C-b>', '<ESC>^i', { desc = 'Beginning of line' })
map('i', '<C-e>', '<End>', { desc = 'End of line' })
map('i', '<C-h>', '<Left>', { desc = 'Move left' })
map('i', '<C-l>', '<Right>', { desc = 'Move right' })
map('i', '<C-j>', '<Down>', { desc = 'Move down' })
map('i', '<C-k>', '<Up>', { desc = 'Move up' })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Insert blank line below
map('n', '<leader>o', 'o<ESC>', { desc = '[o] Insert blank line below' })
-- Insert blank line below
map('n', '<leader>O', 'O<ESC>', { desc = '[O] Insert blank line below' })

-- Move to the previous buffer
map('n', '<leader>[', '<CMD>bp<CR>', { desc = '[bp] Move to previous buffer' })
-- Move to the next buffer
map('n', '<leader>]', '<CMD>bn<CR>', { desc = '[bn] Move to next buffer' })

-- Telescope mappings
-- See `:help telescope.builtin`
map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map(
    'n',
    '<leader>/',
    function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end,
    { desc = '[/] Fuzzily search in current buffer]' }
)
map('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sa', function() require('telescope.builtin').find_files({ follow = true, hidden = true, no_ignore = true }) end, { desc = '[S]earch [A]ll' })
map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- nvim-tree mappings
map('n', '<C-n>', '<CMD>NvimTreeToggle<CR>', { desc = 'Toggle nvimtree' })
map('n', '<leader>e', '<CMD>NvimTreeFocus<CR>', { desc = '[e] Focus nvimtree' })

-- Git
map('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
map('n', '<leader>gb', require('gitsigns').blame_line, { desc = '[G]it [B]lame' })
map(
    'n',
    '[c',
    function()
        if vim.wo.diff then
            return '[c'
        end
        vim.schedule(function()
            require('gitsigns').prev_hunk()
        end)
        return '<Ignore>'
    end,
    {
        desc = 'Jump to prev hunk',
        expr = true,
    }
)

map(
    'n',
    ']c',
    function()
        if vim.wo.diff then
            return ']c'
        end
        vim.schedule(function()
            require('gitsigns').next_hunk()
        end)
        return '<Ignore>'
    end,
    {
        desc = 'Jump to next hunk',
        expr = true,
    }
)
