vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"

local map = vim.keymap.set

map("n", "<leader>so", ":so<CR>")
map("n", "<leader>w", ":write<CR>")
map("n", "<leader>q", ":quit<CR>")
map("n", "<leader>ff", vim.lsp.buf.format)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>cd", vim.lsp.buf.definition)
map("n", "<leader>fe", ":Ex<CR>")


vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

vim.lsp.enable({
	"pyright",
	"ts_ls",
	"rust_analyzer",
	"gopls",
	"clangd",
	"lua_ls",
	"nil_ls",
	"taplo",
	"marksman",
	"yamlls",
})

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

require("mini.pick").setup()

map("n", "<leader>fz", ":Pick files<CR>")
map("n", "<leader>fh", ":Pick help<CR>")
map("n", "<leader>fg", ":Pick grep_live<CR>")

--require("mini.completion").setup()
