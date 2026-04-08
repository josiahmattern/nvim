vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1.10.2" },
	"https://github.com/rafamadriz/friendly-snippets", -- The VS Code snippet library
	"https://github.com/L3MON4D3/LuaSnip",
})

require("blink.cmp").setup({
	-- This handles the VS Code-like expansion
	snippets = {
		preset = "luasnip",
	},

	fuzzy = { prebuilt_binaries = { download = true } },

	keymap = { preset = "default" },

	sources = {
		-- 'snippets' is now powered by friendly-snippets
		default = { "lsp", "path", "snippets", "buffer" },
	},
})

-- Load the snippets from the friendly-snippets library
require("luasnip.loaders.from_vscode").lazy_load()
