-- lua/core/keymaps.lua

local map = vim.keymap.set

-----------------------------------------------------------
-- Leader
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------------------------------
-- Primeagen-style cursor centering & motions
-----------------------------------------------------------
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-o>", "<C-o>zz")

-----------------------------------------------------------
-- Oil file explorer
-----------------------------------------------------------
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File Explorer" })

-----------------------------------------------------------
-- Trouble
-----------------------------------------------------------
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
map("n", "<leader>xw", "<cmd>Trouble lsp toggle<CR>", { desc = "LSP Issues" })

-----------------------------------------------------------
-- Telescope (Primeagen-style)
-----------------------------------------------------------
map("n", "<leader>pf", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>ps", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>pb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>pc", "<cmd>Telescope commands<CR>", { desc = "Commands" })

-----------------------------------------------------------
-- Git (Fugitive)
-----------------------------------------------------------
map("n", "<leader>gs", "<cmd>G<CR>", { desc = "Git Status" })

-----------------------------------------------------------
-- Python: venv selector
-----------------------------------------------------------
map("n", "<leader>vs", "<cmd>VenvSelect<CR>", { desc = "Venv Select" })
map("n", "<leader>vc", "<cmd>VenvSelectCached<CR>", { desc = "Venv Cached" })

-----------------------------------------------------------
-- Harpoon (safe loading)
-----------------------------------------------------------
local ok, harpoon = pcall(require, "harpoon")
if ok then
    -- Add file to harpoon
    map("n", "<leader>a", function()
        harpoon:list():add()
    end, { desc = "Harpoon Add File" })

    -- Toggle menu
    map("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon Menu" })

    -- File jumps 1–5
    for i = 1, 5 do
        map("n", "<leader>" .. i, function()
            harpoon:list():select(i)
        end, { desc = "Harpoon File " .. i })
    end
end
