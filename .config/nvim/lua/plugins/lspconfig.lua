return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "basedpyright",
                    "rust_analyzer",
                    "gopls",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "prismals",
                    "jsonls",
                    "yamlls",
                    "sqlls",
                    "marksman",
                    "clangd",
                },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- GLOBAL DEFAULT (applies to all servers)
            vim.lsp.config("*", {
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
                single_file_support = true,
            })

            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config("pyright", {
                enabled = false,
            })

            -- BasedPyright (Django bliss)
            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        typeCheckingMode = "basic",
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                            autoImportCompletions = true,
                            extraPaths = {
                                "venv/lib/python3.*/site-packages",
                            },
                        },
                    },
                },
            })

            -- Tailwind
            vim.lsp.config("tailwindcss", {
                filetypes = {
                    "html", "css",
                    "javascript", "javascriptreact",
                    "typescript", "typescriptreact",
                },
            })

            -- Clangd
            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--pch-storage=memory",
                    "--completion-style=detailed",
                    "--header-insertion=never",
                    "-j=4",
                },
            })

            -- ENABLE ALL
            vim.lsp.enable({
                "lua_ls",
                "basedpyright",
                "rust_analyzer",
                "gopls",
                "html",
                "cssls",
                "tailwindcss",
                "prismals",
                "jsonls",
                "yamlls",
                "sqlls",
                "marksman",
                "clangd",
            })
        end,
    },
}
