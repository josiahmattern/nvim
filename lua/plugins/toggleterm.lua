vim.pack.add({'https://github.com/akinsho/toggleterm.nvim'})

-- 2. Require and setup
require("toggleterm").setup({
  size = 20,
  open_mapping = [[<c-\>]], -- Press Ctrl+\ to toggle the terminal
  hide_numbers = true,      -- Hide the number column in toggleterm buffers
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,   -- Whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = "float",      -- Options: 'vertical', 'horizontal', 'tab', 'float'
  close_on_exit = true,     -- Close the terminal window when the process exits
  shell = vim.o.shell,
  float_opts = {
      border = "single",    -- Options: 'single', 'double', 'shadow', 'curved'
      winblend = 0,
  }
})

-- 3. Terminal Navigation Keymaps
-- This creates a function to easily escape terminal mode and navigate windows
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  -- Press Esc to exit terminal insert mode
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  
  -- Standard window navigation while inside the terminal
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- Apply these keymaps only when a terminal is opened
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Custom lazygit floating terminal
local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({ 
    cmd = "lazygit", 
    hidden = true, 
    direction = "float",
    float_opts = {
        border = "single",
    },
})

-- Pass the function directly instead of using a global string wrapper
vim.keymap.set("n", "<leader>g", function() lazygit:toggle() end, { desc = "Toggle Lazygit" })
