return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPost",
  config = function()
    require("git-conflict").setup({
      default_mappings = true,
      disable_diagnostics = false,
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
      debug = false,
    })
  end
}
