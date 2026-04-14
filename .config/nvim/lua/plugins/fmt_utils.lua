return {
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{
				"<leader>m",
				function()
					require("treesj").toggle()
				end,
				desc = "Toggle split/join",
			},
			{
				"<leader>j",
				function()
					require("treesj").join()
				end,
				desc = "Join node",
			},
			{
				"<leader>s",
				function()
					require("treesj").split()
				end,
				desc = "Split node",
			},
		},
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
				max_join_length = 180,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		opts = {
			highlight_duration = 500,
			mappings = {
				add = "sa",
				delete = "sd",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				replace = "sr",
				update_n_lines = "sn",
				suffix_last = "l",
				suffix_next = "n",
			},
			n_lines = 20,
			search_method = "cover",
		},
	},
}
