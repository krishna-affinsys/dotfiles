require("config.lazy")
vim.cmd.colorscheme("vague")

local opt = vim.opt

opt.termguicolors = true
opt.timeoutlen = 300
opt.updatetime = 200
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.wrap = false
opt.colorcolumn = "100"
opt.list = true
opt.listchars = { tab = "→ ", trail = "·", nbsp = "◇", extends = "▸", precedes = "◂" }
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.confirm = true
opt.inccommand = "split"
opt.undofile = true
opt.mouse = "a"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>es", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>el", "<cmd>.lua<CR>", { desc = "Run current line" })
vim.keymap.set("v", "<leader>el", ":lua<CR>", { desc = "Run selection" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    group = vim.api.nvim_create_augroup("python-line-length", { clear = true }),
    callback = function(args)
        vim.bo[args.buf].textwidth = 100
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.diagnostic.config({
    virtual_text = {
        spacing = 2,
        prefix = "●",
    },
    signs = true,
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    float = { border = "rounded" },
})
