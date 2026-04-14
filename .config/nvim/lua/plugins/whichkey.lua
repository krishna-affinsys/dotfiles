return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = 300,
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{ "<leader><leader>", group = "Leader" },
			{ "<leader>c", group = "Code" },
				{ "<leader>e", group = "Execute" },
				{ "<leader>f", group = "Find" },
				{ "<leader>j", desc = "Join node" },
				{ "<leader>m", desc = "Toggle split/join" },
				{ "<leader>r", group = "Rename" },
				{ "<leader>s", desc = "Split node" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>x", group = "Diagnostics" },
			{ "<leader>z", group = "Zen" },
			{ "<leader>ca", desc = "Code action" },
			{ "<leader>cf", desc = "Format buffer" },
			{ "<leader>cl", desc = "LSP locations (Trouble)" },
			{ "<leader>co", desc = "Organize imports" },
			{ "<leader>cs", desc = "Symbols (Trouble)" },
			{ "<leader>el", desc = "Run current line" },
			{ "<leader>es", desc = "Source current file" },
			{ "<leader>fb", desc = "Buffers" },
			{ "<leader>fd", desc = "Diagnostics" },
				{ "<leader>ff", desc = "Find files" },
				{ "<leader>fg", desc = "Live grep" },
				{ "<leader>fh", desc = "Help tags" },
				{ "<leader>fz", desc = "Zoxide" },
				{ "<leader>rn", desc = "Rename symbol" },
				{ "<leader>ti", desc = "Toggle inlay hints" },
			{ "<leader>xx", desc = "Diagnostics (Trouble)" },
			{ "<leader>xL", desc = "Location list" },
			{ "<leader>xQ", desc = "Quickfix list" },
			{ "<leader>xX", desc = "Buffer diagnostics (Trouble)" },
			{ "<leader>zz", desc = "Zen mode" },
		})
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
