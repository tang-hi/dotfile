local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
}

function M.config()
  require("copilot").setup {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = false,
        accept_word = "<M-k>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<M-h>",
      },
    },
    panel = { enabled = false },
  }
end

return M
