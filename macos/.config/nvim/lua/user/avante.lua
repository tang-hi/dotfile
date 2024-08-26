local M = {
	"yetone/avante.nvim",
  -- dir = "/home/hayes/repo/avante.nvim",
	event = "VeryLazy",
	build = "make",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below is optional, make sure to setup it properly if you have lazy=true
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}

function M.config()
  local avante = require "avante"

  avante.setup({
    -- your configuration comes here
    provider = "copilot",
  })
end

return M
