vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
-- Infinite undo!!
vim.o.swapfile = false
vim.o.undofile = true
-- default to case insensitive search
vim.o.ignorecase = true
-- unless you use uppercase
vim.o.smartcase = true
-- do not show a line break if it is not there
vim.o.wrap = false
-- indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = false
vim.o.smartindent = true

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight_yank', {}),
	desc = 'Hightlight selection on yank',
	pattern = '*',
	callback = function()
		vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
	end,
})
