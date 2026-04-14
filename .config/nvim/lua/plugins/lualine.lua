return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		require("lualine").setup({
			icons_enabled = true,
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "·", right = "·" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return " " .. str
						end,
					},
				},
				lualine_b = { "branch" },
				lualine_c = {
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
					},
					{
						"filename",
						file_status = true,
						path = 0,
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					"diagnostics",
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
