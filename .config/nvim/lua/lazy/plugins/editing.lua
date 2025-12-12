return {
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
    { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
    { "lewis6991/gitsigns.nvim", event = "BufReadPre", opts = {} },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },
}
