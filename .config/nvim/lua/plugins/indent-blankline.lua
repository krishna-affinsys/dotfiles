return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = { char = "│" },
		scope = { enabled = false },
		exclude = {
			filetypes = {
				"help",
				"lazy",
				"mason",
				"oil",
				"TelescopePrompt",
				"Trouble",
				"markdown",
			},
		},
	},
}
