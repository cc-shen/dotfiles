-- Run :PackerSync
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Post-install/update hook with neovim command
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use {
        'ofirgall/ofirkai.nvim', requires = { 'nvim-treesitter/nvim-treesitter' },
        config = function() require('ofirkai').setup { remove_italics = false } end
    }

end)
