return {
    ----------------------------------------------------------------------
    -- Trouble: diagnostics & LSP navigation with inline previews
    ----------------------------------------------------------------------
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            modes = {
                diagnostics = { auto_open = false },
                lsp = { auto_preview = true },
            },
        },
    },

    ----------------------------------------------------------------------
    -- Mason: installer for LSP servers, formatters, linters
    ----------------------------------------------------------------------
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {},
    },

    ----------------------------------------------------------------------
    -- Mason → LSPConfig
    ----------------------------------------------------------------------
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        opts = {
            ensure_installed = {
                -- General
                "clangd",
                "rust_analyzer",
                "gopls",
                "tsserver",
                "jsonls",
                "yamlls",
                "taplo",
                "marksman",
                "lua_ls",

                -- Python
                "pylsp",
                "ruff_lsp",
            },
        },
    },

    ----------------------------------------------------------------------
    -- Unified LSP configuration for all languages
    ----------------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")
            local cap = require("cmp_nvim_lsp").default_capabilities()

            ------------------------------------------------------------------
            -- Shared on_attach (Primeagen-style)
            ------------------------------------------------------------------
            local on_attach = function(client, bufnr)
                local map = function(lhs, rhs, desc)
                    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
                end

                -- Telescope-powered navigation
                map("gd", "<cmd>Telescope lsp_definitions<CR>", "Go to Definition")
                map("gr", "<cmd>Telescope lsp_references<CR>", "References")
                map("gi", "<cmd>Telescope lsp_implementations<CR>", "Implementations")

                -- Essentials
                map("K", vim.lsp.buf.hover, "Hover")
                map("<leader>rn", vim.lsp.buf.rename, "Rename")
                map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                map("<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols")
                map("<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols")

                -- Primeagen-style diagnostic navigation
                map("[d", "<cmd>lua vim.diagnostic.goto_prev({float=true})<CR>", "Prev Diagnostic")
                map("]d", "<cmd>lua vim.diagnostic.goto_next({float=true})<CR>", "Next Diagnostic")

                if client.name == "ruff_lsp" then
                    -- Disable hover for ruff (pylsp does that)
                    client.server_capabilities.hoverProvider = false
                end
            end

            ------------------------------------------------------------------
            -- Language-specific server configs
            ------------------------------------------------------------------
            local servers = {
                ------------------------------------------------------------------
                -- C/C++
                ------------------------------------------------------------------
                clangd = {
                    cmd = { "clangd", "--background-index", "--clang-tidy" },
                },

                ------------------------------------------------------------------
                -- Rust
                ------------------------------------------------------------------
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = { cargo = { allFeatures = true } },
                    },
                },

                ------------------------------------------------------------------
                -- Go
                ------------------------------------------------------------------
                gopls = {
                    settings = {
                        gopls = {
                            semanticTokens = true,
                            gofumpt = true,
                        },
                    },
                },

                ------------------------------------------------------------------
                -- JS/TS
                ------------------------------------------------------------------
                tsserver = {},

                ------------------------------------------------------------------
                -- JSON
                ------------------------------------------------------------------
                jsonls = {},

                ------------------------------------------------------------------
                -- YAML
                ------------------------------------------------------------------
                yamlls = {
                    settings = {
                        yaml = {
                            keyOrdering = false,
                        },
                    },
                },

                ------------------------------------------------------------------
                -- TOML
                ------------------------------------------------------------------
                taplo = {},

                ------------------------------------------------------------------
                -- Markdown
                ------------------------------------------------------------------
                marksman = {},

                ------------------------------------------------------------------
                -- Lua
                ------------------------------------------------------------------
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                        },
                    },
                },

                ------------------------------------------------------------------
                -- Python: ruff + pylsp with rope
                ------------------------------------------------------------------
                ruff_lsp = {},

                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                pycodestyle = { enabled = false },
                                pyflakes = { enabled = false },
                                pylint = { enabled = false },
                                mccabe = { enabled = false },

                                -- Rope refactoring
                                rope_autoimport = { enabled = true },
                                rope_completion = { enabled = true },
                            },
                        },
                    },
                },
            }

            ------------------------------------------------------------------
            -- Register servers
            ------------------------------------------------------------------
            for name, cfg in pairs(servers) do
                cfg.on_attach = on_attach
                cfg.capabilities = cap
                lspconfig[name].setup(cfg)
            end
        end,
    },
}
