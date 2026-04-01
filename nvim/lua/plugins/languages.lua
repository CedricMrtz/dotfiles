return {

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typescript",
        "tsx",
        "javascript",
        "python",
        "rust",
        "html",
        "css",
        "json",
        "c",
      })
    end,
  },

  -- Mason (instala herramientas)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {

        -- LSP
        "pyright",
        "rust-analyzer",
        "typescript-language-server",
        "eslint-lsp",
        "tailwindcss-language-server",
        "html-lsp",
        "css-lsp",
        "clangd",
        "clang-format",

        -- Formatters / linters
        "prettier",
        "black",
        "ruff",
        "stylua",
      })
    end,
  },
}
