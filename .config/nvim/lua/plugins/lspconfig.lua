return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local servers = {
                "lua_ls",
                "zuban",
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
            }

            require("mason-lspconfig").setup({ ensure_installed = servers })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            }
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                            telemetry = { enable = false },
                        },
                    },
                },
                zuban = {},
                rust_analyzer = {},
                gopls = {},
                html = {},
                cssls = {},
                tailwindcss = {
                    filetypes = {
                        "html",
                        "css",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                    },
                },
                prismals = {},
                jsonls = {},
                yamlls = {},
                sqlls = {},
                marksman = {},
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

            vim.lsp.config("*", {
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
                single_file_support = true,
            })

            vim.lsp.config("pyright", {
                enabled = false,
            })

            vim.lsp.config("basedpyright", {
                enabled = false,
            })

            for server, settings in pairs(servers) do
                vim.lsp.config(server, settings)
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
                    end

                    map("gd", vim.lsp.buf.definition, "Goto definition")
                    map("gD", vim.lsp.buf.declaration, "Goto declaration")
                    map("gr", vim.lsp.buf.references, "References")
                    map("gI", vim.lsp.buf.implementation, "Goto implementation")
                    map("K", vim.lsp.buf.hover, "Hover")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")

                    if not client or client.name ~= "zuban" then
                        return
                    end

                    if client.supports_method("textDocument/inlayHint") then
                        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
                        map("<leader>ti", function()
                            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                            vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
                        end, "Toggle inlay hints")
                    end

                    if client.supports_method("textDocument/documentHighlight") then
                        local group = vim.api.nvim_create_augroup("zuban-document-highlight-" .. event.buf, { clear = true })

                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = group,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
                            buffer = event.buf,
                            group = group,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end

                    map("<leader>co", function()
                        vim.lsp.buf.code_action({
                            apply = true,
                            context = {
                                only = { "source.organizeImports" },
                                diagnostics = {},
                            },
                        })
                    end, "Organize imports")
                end,
            })

            vim.lsp.enable(vim.tbl_keys(servers))
        end,
    },
}
