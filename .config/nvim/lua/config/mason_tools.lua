local M = {}

M.lsp_servers = {
	"lua_ls",
	"ruff",
	"zuban",
	"rust_analyzer",
	"gopls",
	"html",
	"cssls",
	"tailwindcss",
	"prismals",
	"jsonls",
	"yamlls",
	"sqlls",
	"marksman",
	"clangd",
}

M.lsp_packages = {
	"lua-language-server",
	"ruff",
	"zuban",
	"rust-analyzer",
	"gopls",
	"html-lsp",
	"css-lsp",
	"tailwindcss-language-server",
	"prisma-language-server",
	"json-lsp",
	"yaml-language-server",
	"sqlls",
	"marksman",
	"clangd",
}

M.formatters = {
	"asmfmt",
	"biome",
	"clang-format",
	"gofumpt",
	"goimports-reviser",
	"golines",
	"ormolu",
	"prettier",
	"ruff",
	"stylua",
	"taplo",
	"yamlfmt",
}

M.external_formatters = {
	"gleam",
	"rustfmt",
}

local seen = {}

M.ensure_installed = {}

for _, tool_group in ipairs({ M.lsp_packages, M.formatters }) do
	for _, name in ipairs(tool_group) do
		if not seen[name] then
			seen[name] = true
			table.insert(M.ensure_installed, name)
		end
	end
end

table.sort(M.ensure_installed)

return M
