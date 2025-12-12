return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            formatters_by_ft = {
                python = { "ruff_format" },
                lua = { "stylua" },
                rust = { "rustfmt" },
                go = { "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                yaml = { "yamlfmt" },
            },
        },
    },
}
