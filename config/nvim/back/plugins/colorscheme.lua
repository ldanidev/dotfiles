return {
	-- "https://github.com/lsdanii/autumn",
	"https://github.com/mofiqul/dracula.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme('dracula')
	end
}
