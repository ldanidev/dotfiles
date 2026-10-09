return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lsp_config = require("mason-lspconfig")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		})

		mason_lsp_config.setup({
			ensure_installed = {
				"rust_analyzer",
				"lua_ls",
				"ts_ls",
				"wgsl_analyzer",
				"vue_ls"
			},
			automatic_installation = true,
		})
	end
}
