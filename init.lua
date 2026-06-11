vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>w", ":w<CR>")
map("n", "<leader>so", ":so<CR>")
map("n", "<leader>fe", ":Ex<CR>")

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.list = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.termguicolors = true
vim.cmd.colorscheme("catppuccin")

vim.g.netrw_banner = 0

vim.opt.spell = true
vim.opt.spelllang = "en_gb"

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- Completions

	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },

	{ src = "https://github.com/nvim-mini/mini.nvim" },
})

require("nvim-treesitter").setup({
	ensure_installed = { "go", "gomod", "gowork", "gosum", "lua" },
	highlight = { enable = true },
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "rust_analyzer" },
})

--vim.api.nvim_create_autocmd("LspAttach", {
--	callback = function(args)
--		local client = vim.lsp.get_client_by_id(args.data.client_id)
--		if client and client:supports_method("textDocument/completion") then
--			vim.lsp.completion.enable(true, client.id, args.buf, { autocomplet = true })
--		end
--	end,
--})

local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
})

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.keymap.set({ "n" }, "<leader>cf", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
		timeout_ms = 500,
	})
end, { desc = "Format file" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true })

require("conform").setup({
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
})

require("mini.pick").setup()

map("n", "<leader>fz", ":Pick files<CR>")
map("n", "<leader>fh", ":Pick help<CR>")
map("n", "<leader>fg", ":Pick grep_live<CR>")

require("mini.pairs").setup()

