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

    -- Highlight, edit, and navigate code
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }
    -- Additional text objects via treesitter
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- LSP Configuration & Plguins
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
        },
    }

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    }

    -- Fuzzy Finder (files, lsp, etc)
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = fn.executable 'make' == 1
    }

    -- Better wildmenu
    use 'gelguy/wilder.nvim'

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- Add indentation guides even on blank lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                filetype_exclude = { 'dashboard' }
            }
        end,
    }

    -- Opening dashboard
    use 'nvim-tree/nvim-web-devicons'
    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper'
            }
        end,
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- Git
    use 'lewis6991/gitsigns.nvim'

    -- Themes
    use 'sainnhe/gruvbox-material'

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
        autocmd BufWritePost plugins.lua source <afile> | silent! LspStop | silent! LspStart | PackerCompile
    augroup end
]])

-- SECTION: Plugin Configurations
-- [[ Configure gruvbox-material ]]
g.gruvbox_material_foreground = 'material'
g.gruvbox_material_background = 'medium'
g.gruvbox_material_enable_italic = 1
g.gruvbox_material_better_performance = 1

-- [[ Configure lualine ]]
-- Inspired from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
require('lualine').setup {
    options = {
        component_separators = '|',
        section_separators = '',
    },
}

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

-- [[ Configure Treesitter ]]
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

-- [[ Configure LSP and more ]]
-- Inspired from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local servers = {
    -- pyright = {},
    -- yamlls = {},
    sumneko_lua = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}
-- Setup neovim lua configuration
require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
end

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}
-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
