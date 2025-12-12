return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        },
    },

    { "mbbill/undotree", cmd = { "UndotreeToggle", "UndotreeFocus" } },

    {
        "ggandor/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        config = function()
            require("leap").add_default_mappings(true)
        end,
    },

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },

    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git", "Gdiff", "Gblame" },
    },

    { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
}
