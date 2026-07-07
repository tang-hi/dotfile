local M = {
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = "BufReadPre",
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
			requires = {
				"williamboman/mason.nvim",
			},
			lazy = true,
		},
	},
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

function M.config()
	require("mason").setup(settings)
	-- mason-lspconfig v2: `automatic_installation` was removed. `automatic_enable`
	-- (default true) calls vim.lsp.enable() for each installed server, so we no
	-- longer iterate servers in lsp.lua to call lspconfig[server].setup().
	require("mason-lspconfig").setup({
		ensure_installed = require("utils").servers,
		automatic_enable = true,
	})
end

return M
