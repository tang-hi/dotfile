return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      rust = { "rustfmt" },
      python = { "black" },
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      toml = { "prettier" },
      markdown = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters = {
      ["clang-format"] = {
        prepend_args = { "-style=file", "--fallback-style=Google" },
      },
      black = {
        prepend_args = { "--fast", "-l", "80" },
      },
      prettier = {
        prepend_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      },
    },
  },
}
