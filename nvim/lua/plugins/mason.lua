return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "pyright",
        "typescript-language-server",
        "eslint-lsp",
        "intelephense",
        "clojure-lsp",

        -- formatters/linters
        "prettier",
        "clj-kondo",
        "cljfmt",

        -- debugging (optional)
      },
    },
  },
}
