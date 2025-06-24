require("config.lazy")
vim.cmd.colorscheme("vague")

vim.o.termguicolors = true

-- Decrease update time
vim.o.timeoutlen = 500
vim.o.updatetime = 200

-- Better editor UI
vim.o.number = true
vim.o.numberwidth = 2
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true

-- Better editing experience
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.wrap = false
vim.o.textwidth = 300
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = -1 -- If negative, shiftwidth value is used
vim.o.list = true
vim.o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- Makes neovim and host OS clipboard play nicely with each other
vim.o.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Undo and backup options
vim.o.undofile = true

vim.opt.mouse = "a"

vim.diagnostic.config({
    virtual_text = true, -- shows inline text (error/warning under line)
    signs = true,      -- shows icons in the sign column
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
