local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sf', builtin.live_grep, {})

-- lsp pickers - think these won't work for now, but sound cool for later
vim.keymap.set('n', '<leader>d', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>t', builtin.lsp_type_definitions, {})

