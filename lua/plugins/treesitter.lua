return {
    -- Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
	    highlight = {
		enable = true,
	    },
	    indent = {enable = true},
	    autotags = {enable = true},
	    ensure_installed = {
		"lua",
		"tsx",
		"css",
		"html",
		"javascript",
		"typescript",
		"python",
		"c", 
		"vim", 
		"vimdoc", 
		"query", 
		"markdown", 
		"markdown_inline",
		"rust"
	    },
	    auto_install = false,

	})
    end
}
