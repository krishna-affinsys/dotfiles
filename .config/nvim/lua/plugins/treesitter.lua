return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		},
		highlight = { enable = true },
		indent = { enable = true },
	},
	config = function(_, opts)
		local ok_legacy, legacy = pcall(require, "nvim-treesitter.configs")
		if ok_legacy then
			legacy.setup(opts)
			return
		end

		local ok_modern, treesitter = pcall(require, "nvim-treesitter")
		if not ok_modern then
			return
		end

		treesitter.setup({})

		if opts.highlight and opts.highlight.enable then
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user-treesitter-highlight", { clear = true }),
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end

		if opts.indent and opts.indent.enable then
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user-treesitter-indent", { clear = true }),
				callback = function(args)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end
	end,
}
