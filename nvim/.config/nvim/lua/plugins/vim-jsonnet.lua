return {
  -- 1. Install the vim-jsonnet plugin
  { "google/vim-jsonnet" },

  -- 2. (Optional) Add Treesitter support for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "jsonnet" })
      end
    end,
  },

  -- 3. (Optional) Auto-install the LSP via Mason and set it up via lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonnet_ls = {}, -- This enables the Jsonnet Language Server
      },
    },
  },

  -- 4. Ensure Mason installs the language server
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "jsonnet-language-server" })
    end,
  },
}
