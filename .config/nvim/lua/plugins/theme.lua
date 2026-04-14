-- Lazy
return {
  "vague2k/vague.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  },
  config = function(_, opts)
    require("vague").setup(opts)
  end,
}
