require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "clangd",
    "cmake",
    "marksman",
    "rust_analyzer",
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

require('mason-lspconfig').setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
})
