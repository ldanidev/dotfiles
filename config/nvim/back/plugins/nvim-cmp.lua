return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text paths
		"hrsh7th/cmp-path", -- source for fs paths
    },
	config = function()
		local cmp = require("cmp")
		cmp.setup({
            completion = {
                completeop = "menu,menuone,preview,noselect"
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(),
				['<CR>'] = cmp.mapping.confirm({
      				behavior = cmp.ConfirmBehavior.Insert,
      				select = false,
    			})
            }),
            sources = cmp.config.sources({
                { name = "buffer" },
                { name = "path" },
                { name = "nvim_lsp" },
            }),
		})
	end
}
