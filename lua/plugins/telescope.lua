vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
})

local builtin = require('telescope.builtin')
local showhidden = false

-- Wrap the toggle logic in a function
vim.keymap.set('n', '<leader>sh', function()
  showhidden = not showhidden
  print("Show hidden files: " .. tostring(showhidden)) -- Optional feedback
end, { desc = 'Toggle hidden files in Telescope' })

-- Wrap the call in a function so it dynamically reads the current 'showhidden' state,
-- and pass the options to find_files, not the keymap setting.
vim.keymap.set('n', '<C-p>', function()
  builtin.find_files({ hidden = showhidden })
end, { desc = 'Telescope find files' })

-- These remaining maps are correct because they don't require custom arguments
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
