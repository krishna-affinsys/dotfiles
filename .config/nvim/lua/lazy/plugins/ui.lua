return {
    { "nvim-lua/plenary.nvim", lazy = true },

    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = false,
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = { options = { theme = "auto" } },
    }
}
