local fn = vim.fn
local cmd = vim.cmd
local g = vim.g

local ensure_packer = function()
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Run :PackerSync
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- File tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }

    -- Highlight, edit, and navigate code
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    -- Additional text objects via treesitter
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- Fuzzy Finder (files, lsp, etc)
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }

    -- Better wildmenu
    use 'gelguy/wilder.nvim'

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- LSP

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Git
    use 'lewis6991/gitsigns.nvim'

    -- WhichKey because I can't remember anything
    use 'folke/which-key.nvim'

    -- Themes
    use {
        'catppuccin/nvim',
        as = 'catppuccin',
    }

    -- Auto set-up
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Adapted from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if packer_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | silent! LspStop | silent! LspStart | PackerSync
    augroup end
]])

-- SECTION: Plugin Configurations
-- [[ Configure catppuccin ]]
require('catppuccin').setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        telescope = {
            enabled = true,
        },
        which_key = false,
    },
})

-- [[ Configure which-key ]]
require('which-key').setup()

-- [[ Configure nvim-tree ]]
require('nvim-tree').setup({
    disable_netrw = true,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    renderer = {
        root_folder_label = false,
        icons = {
            show = {
                git = false,
            },
        },
    },
    filters = {
        dotfiles = false,
    },
})

-- [[ Configure lualine ]]
-- Inspired from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
require('lualine').setup({
    options = {
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {
            'packer',
            'NvimTree',
        },
    },
})

-- [[ Configure indent-blankline.nvim ]]
require('indent_blankline').setup({
    show_current_context = true,
})

-- [[ Configure wilder.nvim ]]
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('pipeline', {
    wilder.debounce(30),
    wilder.branch(
        wilder.cmdline_pipeline({ language = 'python' }),
        wilder.search_pipeline()
    ),
})
wilder.set_option('renderer', wilder.popupmenu_renderer({
    highlighter = wilder.basic_highlighter(),
}))

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require('telescope')
telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
})
telescope.load_extension('fzf')

-- [[ Configure treesitter ]]
-- Inspired from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'clojure', 'lua', 'python', 'javascript', 'typescript', 'tsx', 'php',
        'help', 'vim', 'regex',
        'yaml', 'css', 'scss', 'json', 'jsonc',
        'graphql', 'http', 'html',
        'make', 'dockerfile'
    },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
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
            set_jumps = true,
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

-- [[ Configure Gitsigns ]]
-- Inspired from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

