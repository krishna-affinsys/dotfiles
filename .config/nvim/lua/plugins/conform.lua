return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			desc = "Format buffer",
		},
	},
	config = function()
		local util = require("conform.util")
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
				rust = { "rustfmt" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				go = { "gofumpt", "golines", "goimports-reviser" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				haskell = { "ormolu" },
				yaml = { "yamlfmt" },
				-- templ = { "prettier" },
				html = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },
				toml = { "taplo" },
				markdown = { "prettier_markdown" },
				astro = { "biome" },
				gleam = { "gleam" },
				-- sql = { "sqlfmt" },
				asm = { "asmfmt" },
				css = { "biome" },
				vue = { "biome" },
				svelte = { "biome" },
			},
			format_on_save = {
				timeout_ms = 2000,
				lsp_format = "fallback",
			},
			formatters = {
				ruff_fix = {
					args = {
						"check",
						"--line-length",
						"100",
						"--fix",
						"--force-exclude",
						"--exit-zero",
						"--no-cache",
						"--stdin-filename",
						"$FILENAME",
						"-",
					},
				},
				ruff_format = {
					prepend_args = { "--line-length", "100" },
				},
				biome = {
					command = util.find_executable({
						mason_bin .. "biome",
						"node_modules/.bin/biome",
					}, "biome"),
					args = function(self, ctx)
						return {
							"format",
							"--stdin-file-path",
							"$FILENAME",
							"--indent-style",
							vim.bo[ctx.buf].expandtab and "space" or "tab",
							"--indent-width",
							tostring(ctx.shiftwidth),
							"--line-width",
							"100",
							"--html-formatter-enabled=true",
							"--html-formatter-line-width=100",
						}
					end,
				},
				prettier_markdown = {
					command = util.find_executable({
						mason_bin .. "prettier",
						"node_modules/.bin/prettier",
						vim.fn.stdpath("data")
							.. "/mason/packages/yaml-language-server/node_modules/yaml-language-server/node_modules/.bin/prettier",
					}, "prettier"),
					args = function(self, ctx)
						return {
							"--stdin-filepath",
							ctx.filename,
							"--parser",
							"markdown",
							"--prose-wrap",
							"always",
							"--print-width",
							"100",
						}
					end,
				},
			},
		})
	end,
}
