return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({ PATH = "prepend" })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
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
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Default config for all language servers
            local default_config = {
                capabilities = capabilities,
                single_file_support = true,
                flags = {
                    debounce_text_changes = 150,
                },
            }

            -- Special configurations for specific servers
            local server_configs = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                            telemetry = { enable = false },
                        },
                    },
                },
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "off",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "workspace",
                                autoImportCompletions = true,
                                -- Django-specific settings
                                djangoPath = { "django" },
                                extraPaths = { "venv/lib/python3.*/site-packages" },
                            },
                        },
                    },
                },
                tailwindcss = {
                    filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                    root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts",
                        "package.json"),
                },
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--pch-storage=memory",
                        "--completion-style=detailed",
                        "--header-insertion=never",
                        "-j=4",
                    },
                },
            }

            -- Setup all servers
            for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
                local config = vim.tbl_deep_extend("force", default_config, server_configs[server] or {})
                lspconfig[server].setup(config)
            end
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
        },
    },
}
