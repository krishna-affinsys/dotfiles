return {
    "stevearc/oil.nvim",
    lazy = false, -- important
    cmd = "Oil",
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        require("oil").setup({
            default_file_explorer = true,

            view_options = {
                show_hidden = true,
            },

            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",

                ["<C-s>"] = {
                    "actions.select",
                    opts = { vertical = true },
                    desc = "Open the entry in a vertical split",
                },

                ["<C-h>"] = {
                    "actions.select",
                    opts = { horizontal = true },
                    desc = "Open the entry in a horizontal split",
                },

                ["<C-t>"] = {
                    "actions.select",
                    opts = { tab = true },
                    desc = "Open the entry in new tab",
                },

                ["<C-p>"] = "actions.preview",
                ["q"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",

                ["~"] = {
                    "actions.cd",
                    opts = { scope = "tab" },
                    desc = ":tcd to the current oil directory",
                },

                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },

            float = {
                padding = 3,
                max_width = 64,
                border = "single",
            },
        })

        -- Open Oil automatically when nvim is launched on a directory
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                local arg = vim.fn.argv(0)

                if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
                    require("oil").open(arg)
                end
            end,
        })
    end,
}
