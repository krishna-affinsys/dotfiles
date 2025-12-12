local M = {}

M.create = function(event, opts)
    vim.api.nvim_create_autocmd(event, opts)
end

return M
