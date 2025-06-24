return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>gf",
            function()
                require("conform").format({ async = true })
            end,
            mode = { "n", "v" }, -- Ensure it works in normal and visual modes
            desc = "Format buffer",
        },
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff" },
                rust = { "rustfmt" },
                javascript = { "prettier", stop_after_first = true },
                javascriptreact = { "prettier", stop_after_first = true },
                typescript = { "prettier", stop_after_first = true },
                typescriptreact = { "prettier", stop_after_first = true },
                go = { "gofumpt", "golines", "goimports-reviser" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                haskell = { "ormolu" },
                yaml = { "yamlfmt" },
                html = { "prettier" },
                json = { "prettier" },
                markdown = { "prettier" },
                gleam = { "gleam" },
                asm = { "asmfmt" },
                css = { "prettier", stop_after_first = true },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })

        -- Auto format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
}
