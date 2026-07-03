vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- Resize windows
vim.keymap.set({ 'n', 'i', 'v' }, '<S-Up>', ':resize +2<CR>', { noremap = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<S-Down>', ':resize -2<CR>', { noremap = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<S-Left>', ':vertical resize +2<CR>', { noremap = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<S-Right>', ':vertical resize -2<CR>', { noremap = true })

-- diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- move cursor in insert mode
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move cursor to the left' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move cursor to the right' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move cursor down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move cursor up' })
