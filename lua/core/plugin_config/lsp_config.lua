require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" }
})

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.format(), {})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions, {})
  vim.keymap.set('n', '<N>', vim.lsp.buf.hover, {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
