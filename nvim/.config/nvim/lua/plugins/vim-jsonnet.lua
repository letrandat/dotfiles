return {
  -- Core jsonnet plugin
  { "google/vim-jsonnet" },

  -- Auto-install the LSP server (mason-lspconfig will auto-enable it)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "jsonnet-language-server" })
    end,
  },
}
