-- Lazy
return {
  "vague2k/vague.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    on_highlights = function(hl, colors)
      hl["@function.call"] = { fg = colors.func }
      hl["@function.method.call"] = { fg = colors.func }
      hl["@keyword.import"] = { fg = colors.keyword, bold = true }
      hl["@module"] = { fg = colors.type }
      hl["@module.builtin"] = { fg = colors.builtin, bold = true }
      hl["@lsp.type.function"] = { link = "@function" }
      hl["@lsp.type.method"] = { link = "@function.method" }
      hl["@lsp.type.namespace"] = { link = "@module" }
      hl["@lsp.type.property"] = { link = "@property" }
      hl["@lsp.type.variable"] = { link = "@variable" }
      hl["@lsp.typemod.variable.definition"] = { link = "@variable" }
    end,
  },
  config = function(_, opts)
    require("vague").setup(opts)
  end,
}
