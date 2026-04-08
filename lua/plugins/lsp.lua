vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason-lspconfig.nvim",
})

require("mason").setup()

-- Define your servers
local servers = { "lua_ls", "ts_ls", "tailwindcss", "emmet_language_server" }

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

-- 1. Setup global capabilities for Blink
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- 2. Configure the servers globally using the new API
-- This replaces lspconfig[server].setup({ capabilities = capabilities })
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- 3. Enable the servers individually (The "0.11" Logic)
-- This is the modern replacement for the loop you had before
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- treat all .js as .jsx
vim.filetype.add({
  extension = {
    js = 'javascriptreact',
  }
})

-- Create an autocommand that runs every time an LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Create a helper function for setting maps to keep things clean
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Core navigation
    map('gd', vim.lsp.buf.definition, 'Go to Definition')
    map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
    map('gr', vim.lsp.buf.references, 'Go to References')
    map('gI', vim.lsp.buf.implementation, 'Go to Implementation')
    map('go', vim.lsp.buf.type_definition, 'Type Definition')

    -- Documentation and Help
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gs', vim.lsp.buf.signature_help, 'Signature Help')

    -- Actions
    map('<leader>rn', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

    -- Formatting (maps to <leader>f)
    map('<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, 'Format Document')
  end,
})
