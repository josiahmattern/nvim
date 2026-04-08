-- 1. Install dependencies and the plugin using the correct 'version' key for the branch
vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" }
})

local harpoon = require("harpoon")
harpoon:setup()

-- 3. Keymaps
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon quick menu" })

vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next" })
