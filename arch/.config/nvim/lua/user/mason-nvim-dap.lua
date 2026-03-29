return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
  cmd = { "DapInstall", "DapUninstall" },
  opts = {
    ensure_installed = { "codelldb" },
    automatic_installation = true,
  },
}
