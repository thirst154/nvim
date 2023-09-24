local lsp_zero = require('lsp-zero')
local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- confirm completion
    -- ['<C-Space>'] = cmp.mapping.confirm({select = true}),
  })
})

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'lua_ls', 'pylyzer', 'biome','emmet_language_server'},
  handlers = {
    lsp_zero.default_setup,
  },
})
