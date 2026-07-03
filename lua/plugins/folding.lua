-- -- folding

vim.pack.add { { src = Gh 'kevinhwang91/nvim-ufo' }, Gh 'kevinhwang91/promise-async' }

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require('ufo').setup {
  provider_selector = function(bufnr, filetype, buftype) return { 'lsp', 'indent' } end,
  preview = {
    win_config = {
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    },
  },
}

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Open folds except kinds' })
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close folds with' })
vim.keymap.set('n', 'zK', require('ufo').peekFoldedLinesUnderCursor, { desc = 'Peek folded lines under cursor' })
