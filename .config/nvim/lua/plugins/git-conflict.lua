return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = function()
    require("git-conflict").setup({
      default_mappings = true, -- Enable default keybindings
      disable_diagnostics = false, -- Keep LSP diagnostics enabled
      highlights = { -- Custom highlight groups
        incoming = "DiffAdd",
        current = "DiffText",
      },
      debug = false, -- Debugging logs
    })
  end
}
