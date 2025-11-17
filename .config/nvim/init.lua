require("config.lazy")
vim.cmd.colorscheme("vague")

vim.o.termguicolors = true

-- Decrease update time
vim.o.timeoutlen = 500
vim.o.updatetime = 200

-- Better editor UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.wrap = true
vim.o.textwidth = 300
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.list = true
vim.o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- Makes neovim and host OS clipboard play nicely with each other
vim.o.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Creates an undofile just in case you need to undo to the previous version
vim.o.undofile = true

-- Enable mouse actions for vim
vim.opt.mouse = "a"


vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", "<cmd>:.lua<CR>")
vim.keymap.set("v", "<space>x", "<cmd>:lua<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
