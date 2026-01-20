return {
  -- VimTeX config
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_method = "skim" -- change if not macOS
      vim.g.vimtex_quickfix_mode = 0
    end,
  },

  -- TexLab (LSP) config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true,
              },
            },
          },
        },
      },
    },
  },
}
