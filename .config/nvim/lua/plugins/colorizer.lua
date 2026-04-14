return {
	"norcalli/nvim-colorizer.lua",
	ft = {
		"css",
		"html",
		"javascriptreact",
		"lua",
		"scss",
		"typescriptreact",
	},
	config = function()
		require("colorizer").setup({
			"*",
			css = { rgb_fn = true },
		})
	end,
}
