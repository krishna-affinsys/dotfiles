require("lazy.init")

require("core.options")
require("core.keymaps")
require("core.autocmds")

require("lazy").setup("lazy.plugins", {
    defaults = { lazy = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
                "matchit", "tohtml", "tutor",
            },
        },
    },
})

