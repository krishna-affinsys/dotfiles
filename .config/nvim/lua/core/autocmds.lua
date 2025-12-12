local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanks
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remove trailing whitespace
autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
