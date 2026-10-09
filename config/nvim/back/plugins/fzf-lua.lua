return {
	"ibhagwan/fzf-lua",
	opts = {
		lsp = {
			symbols = {
				symbol_style = false,
			}
		},
	},
	init = function()
		vim.api.nvim_create_user_command('ConfigOpen', function()
			require('fzf-lua').files({ cwd = vim.fn.stdpath("config") })
		end, {})
	end,
	keys = {
		{ "<leader>f",  function() require('fzf-lua').git_files() end },
		{ "<leader>pf", function() require('fzf-lua').files() end },
		{ "<leader>/",  function() require('fzf-lua').live_grep() end },
		{ "<leader>s",  function() require('fzf-lua').lsp_document_symbols() end },
		{ "<leader>b",  function() require('fzf-lua').buffers() end },
	}
}
