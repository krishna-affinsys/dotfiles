local M = {}

function M.nmap(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
end

function M.vmap(lhs, rhs, desc)
    vim.keymap.set("v", lhs, rhs, { desc = desc })
end

return M
