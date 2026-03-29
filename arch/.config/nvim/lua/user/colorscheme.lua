local M = {
  "catppuccin/nvim",
  name = "catppuccin-latte",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("catppuccin").setup {
    flavour = "latte",
    background = { light = "latte" },
    transparent_background = false,
    term_colors = true,
    integrations = {
      cmp = true,
      dap = true,
      dap_ui = true,
      flash = true,
      gitsigns = true,
      mason = true,
      noice = true,
      notify = true,
      nvimtree = true,
      rainbow_delimiters = true,
      telescope = { enabled = true },
      treesitter = true,
      which_key = true,
      indent_blankline = { enabled = true },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      mini = { enabled = true },
    },
  }
  vim.cmd.colorscheme "catppuccin-latte"
end

return M
