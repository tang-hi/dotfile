local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
    },
  },
}

function M.config()
  require("ts_context_commentstring").setup {}

  -- Parsers to install. markdown_inline is injected into markdown
  -- automatically, so no FileType entry is needed for it.
  local parsers = {
    "lua", "markdown", "markdown_inline", "bash", "python",
    "cpp", "c", "rust", "toml", "go", "java", "html",
    "javascript", "typescript",
  }

  require("nvim-treesitter").install(parsers)

  -- Start highlighting + indent for any buffer whose filetype has a parser.
  -- Mirrors the old config's disable lists: css disabled for highlight,
  -- python + css disabled for indent.
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      if ft == "css" or ft == "" then
        return
      end

      -- pcall in case a parser isn't installed yet for this filetype
      local ok = pcall(vim.treesitter.start, args.buf)
      if not ok then
        return
      end

      if ft ~= "python" then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M
