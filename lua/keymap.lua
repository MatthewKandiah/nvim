vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

local oil = require('oil')
local oil_actions = require('oil.actions')
vim.keymap.set('n', '<leader>o', oil.open)
vim.keymap.set('n', '<leader>_', oil_actions.open_cwd.callback)

local function insertTodoComment()
  local current_line_number = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, current_line_number, current_line_number, false, { 'TODO-Matt' })
  require('Comment.api').comment.linewise.count(2)
  require('Comment.api').uncomment.linewise.current()
  vim.cmd("normal j$")
end
vim.keymap.set({ 'n' }, '<leader>t', insertTodoComment)

local function upperCaseSurroundingWord()
  vim.cmd("normal gUiw")
end
local function upperCaseSurroundingBigWord()
  vim.cmd("normal gUiW")
end
vim.keymap.set({ 'n' }, '<leader>u', upperCaseSurroundingWord)
vim.keymap.set({ 'n' }, '<leader>U', upperCaseSurroundingBigWord)

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
