-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to harpoon" })
vim.keymap.set("n", "<leader>t", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle quick menu" })

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Go to 1 harpoon" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Go to 2 harpoon" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Go to 3 harpoon" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Go to 4 harpoon" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end, { desc = "Go to Previous Buffer" })
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, { desc = "Go to Next Buffer" })

vim.keymap.set("n", "<leader>fs", "<cmd>Telescope symbols<cr>", { desc = "Find Symbols" })

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Lazy Git" })
