vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/williamboman/mason-lspconfig.nvim",
})

require("mason").setup()

-- Define your servers
local servers = { "lua_ls", "ts_ls", "tailwindcss" }

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
