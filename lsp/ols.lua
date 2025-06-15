vim.lsp.config('ols', {
  settings = {
    collections = {
      {name = "core", path = vim.env.ODIN_ROOT .. "/core"},
      {name = "vendor", path = vim.env.ODIN_ROOT .. "/vendor"},
      {name = "base", path = vim.env.ODIN_ROOT .. "/base"},
    }
  }
})
