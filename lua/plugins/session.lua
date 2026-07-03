vim.pack.add { Gh 'olimorris/persisted.nvim' }

require('persisted').setup {
  should_save = function()
    if vim.bo.filetype == 'neo-tree' then return false end
    return true
  end,
}
vim.api.nvim_create_autocmd('User', {
  pattern = 'PersistedSavePre',
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].filetype == 'neo-tree' then vim.api.nvim_buf_delete(buf, { force = true }) end
    end
  end,
})
