return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts)
		require 'lsp_signature'.setup({
			-- Get signatures (and _only_ signatures) when in argument lists.
			doc_lines = 0,
			handler_opts = {
				border = "none"
			},
		})
	end
}
