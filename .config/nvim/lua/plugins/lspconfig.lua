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
                    "yamlls", "sqlls",
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

            -- Function to set keybindings
            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local keymap = vim.keymap.set

                keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
                keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
                keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
            end

            -- Default config for all language servers
            local default_config = {
                capabilities = capabilities,
                on_attach = on_attach,
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
                pylsp = {
                    configurationSources = { "flake8" },
                    plugins = {
                        jedi = {
                            extra_paths = { "./src" }, -- Add paths for Jedi to search for modules
                        },
                        pycodestyle = {
                            enabled = true,
                            ignore = { 'W391' },
                            maxLineLength = 100,
                        },
                        flake8 = {
                            enabled = true,
                            maxLineLength = 100,
                        },
                        pylint = {
                            enabled = true,
                            args = { '--rcfile=./pylintrc' },
                        },
                        yapf = { enabled = false },
                        pyls_mypy = { enabled = true, live_mode = false },
                        pyls_black = { enabled = true },
                        pyls_isort = { enabled = true },
                    },
                },

                tailwindcss = {
                    filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                    root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "package.json"),
                },
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--pch-storage=memory",
                        "--completion-style=detailed",
                        "--header-insertion=never",
                        "-j=4",
                        "--clang-tidy",
                        "--all-scopes-completion",
                        "--compile-commands-dir=build",
                    },
                    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
                    init_options = {
                        clangdFileStatus = true,
                    },
                    on_new_config = function(new_config, _)
                        local cpp_include_path = "/usr/include/c++/13"
                        local cpp_include_fallback = "/usr/include/x86_64-linux-gnu/c++/13"

                        if vim.fn.isdirectory(cpp_include_path) == 0 then
                            cpp_include_path = cpp_include_fallback
                        end

                        table.insert(new_config.cmd, "--query-driver=*")
                        table.insert(new_config.cmd, "--extra-arg=-I" .. cpp_include_path)
                    end,
                },
            }

                -- Setup all servers
                for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
                    local config = vim.tbl_deep_extend("force", default_config, server_configs[server] or {})
                    lspconfig[server].setup(config)
                end

                local configs = require("lspconfig.configs")
                if not configs.pyrefly then
                    configs.pyrefly = {
                        default_config = {
                            cmd = { "uv", "run", "pyrefly", "lsp" },
                            filetypes = { "python" },
                            root_dir = function(fname)
                                return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
                            end,
                            settings = {},
                        },
                    }
                end

                lspconfig.pyrefly.setup(vim.tbl_deep_extend("force", default_config, {
                    -- Add custom settings if needed
                }))
            end,
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "williamboman/mason-lspconfig.nvim",
            },
        },
    }
