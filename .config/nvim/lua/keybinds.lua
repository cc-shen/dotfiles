-- Leader is ',' see basics.lua
local map = function(modes, trigger, cmd, description)
    local opts = {
        noremap = true,
        desc = description,
    }
    vim.keymap.set(modes, trigger, cmd, opts)
end
local set = vim.keymap.set

-- Quickly go back to normal mode
set('i', 'kj', '<Esc>', { noremap = true })
set('v', 'kj', '<Esc>', { noremap = true })

-- Moving within insert mode
map('i', '<C-b>', '<ESC>^i', 'Beginning of line')
map('i', '<C-e>', '<End>', 'End of line')
map('i', '<C-h>', '<Left>', 'Move left')
map('i', '<C-l>', '<Right>', 'Move right')
map('i', '<C-j>', '<Down>', 'Move down')
map('i', '<C-k>', '<Up>', 'Move up')

-- Remap for dealing with word wrap
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Insert blank line below
map('n', '<leader>o', 'o<ESC>', '[o] Insert blank line below')
-- Insert blank line below
map('n', '<leader>O', 'O<ESC>', '[O] Insert blank line below')

-- Move to the previous buffer
map('n', '<leader>[', '<CMD>bp<CR>', '[bp] Move to previous buffer')
-- Move to the next buffer
map('n', '<leader>]', '<CMD>bn<CR>', '[bn] Move to next buffer')

-- Telescope mappings
-- See `:help telescope.builtin`
map('n', '<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
map('n', '<leader><space>', require('telescope.builtin').buffers, '[ ] Find existing buffers')
map('n', '<leader>/',
    function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, '[/] Fuzzily search in current buffer]'
)
map('n', '<leader>sf', require('telescope.builtin').find_files, '[S]earch [F]iles')
map('n', '<leader>sa',
    function()
        require('telescope.builtin').find_files({ follow = true, hidden = true, no_ignore = true })
    end, '[S]earch [A]ll')
map('n', '<leader>sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
map('n', '<leader>sw', require('telescope.builtin').grep_string, '[S]earch current [W]ord')
map('n', '<leader>sg', require('telescope.builtin').live_grep, '[S]earch by [G]rep')
map('n', '<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')

-- nvim-tree mappings
map('n', '<C-n>', '<CMD>NvimTreeToggle<CR>', 'Toggle nvimtree')
map('n', '<leader>e', '<CMD>NvimTreeFocus<CR>', '[e] Focus nvimtree')

-- Git
map('n', '<leader>gs', require('telescope.builtin').git_status, '[G]it [S]tatus')
map('n', '<leader>gb', require('gitsigns').blame_line, '[G]it [B]lame')
set('n', '[c',
    function()
        if vim.wo.diff then
            return '[c'
        end
        vim.schedule(function()
            require('gitsigns').prev_hunk()
        end)
        return '<Ignore>'
    end, {
        desc = 'Jump to prev hunk',
        expr = true,
    }
)
set('n', ']c',
    function()
        if vim.wo.diff then
            return ']c'
        end
        vim.schedule(function()
            require('gitsigns').next_hunk()
        end)
        return '<Ignore>'
    end, {
        desc = 'Jump to next hunk',
        expr = true,
    }
)

-- LSP
map('n', '<space>of', vim.diagnostic.open_float, '[o]pen_[f]loat')
map('n', '[d', vim.diagnostic.goto_prev, 'Go to prev diagnostic')
map('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
map('n', '<space>q', vim.diagnostic.setloclist, 'setloclist')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = '[g]oto [D]eclaration' })
    set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = '[g]oto [d]efinition' })
    set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = '[g]oto [r]eferences' })
    set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Display hover info' })
    set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = '[g]oto [i]mplementation' })
    set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = 'Open signature_help' })
    set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = '[w]orkplace [a]dd folder' })
    set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = '[w]orkplace [r]emove folder' })
    set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = ev.buf, desc = '[w]orkplace [l]ist folders' })
    set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = 'Type [D]efinition' })
    set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = '[r]e[n]ame' })
    set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = '[c]ode [a]ction' })
    set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, { buffer = ev.buf, desc = '[f]ormat' })
  end,
})
