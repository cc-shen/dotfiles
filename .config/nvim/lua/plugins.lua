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

    -- File searching
    -- May require installing python3-dev
    use {
        'Yggdroot/LeaderF',
        run = ":LeaderfInstallCExtension",
    }

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Github Copilot
    -- Use :Copilot setup afterwards
    use 'github/copilot.vim'

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Themes
    use 'Shatur/neovim-ayu'

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
if is_bootstrap then
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
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- SECTION: Plugin Configurations
-- [[ Configure ayu ]]
require('ayu').setup {
    mirage = true,
}

-- [[ Configure lualine ]]
-- Inspired from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
require('lualine').setup {
    options = {
        theme = 'ayu',
        component_separators = '|',
        section_separators = '',
    },
}

-- [[ Configure Treesitter ]]
-- Inspired from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'typescript', 'help' },

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

-- [[ Configure LeaderF ]]
-- Inspired from https://github.com/jdhao/nvim-config
g.Lf_UseCache = 0
g.Lf_UseVersionControlTool = 0
g.Lf_IgnoreCurrentBufferName = 1
g.Lf_DefaultMode = 'FullPath'
g.Lf_UseVersionControlTool = 0
g.Lf_ShowHidden = 1
g.Lf_ShortcutF = ''
g.Lf_ShortcutB = ''
g.Lf_WorkingDirectoryMode = 'a'
g.Lf_WindowPosition = 'popup'
g.Lf_PreviewInPopup = 1

g.Lf_WildIgnore = {
    ['dir'] = {'.git', '__pycache__', '.DS_Store'},
    ['file'] = {
        '*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png',
        '*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz',
        '*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp',
        '*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf',
        '*.mp3', '*.aac'
    },
}
