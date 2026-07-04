vim.pack.add { Gh 'folke/sidekick.nvim' }

require('sidekick').setup {
  nes = {
    enabled = true,
  },
  copilot = {
    status = {
      enabled = true,
    },
  },
  cli = {
    mux = {
      backend = 'tmux',
      enabled = true,
      create = 'split',
      split = {
        vertical = true,
        size = 0.25,
      },
    },
  },
}

vim.keymap.set('n', '<Tab>', function()
  if not require('sidekick').nes_jump_or_apply() then return '<Tab>' end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

-- Toggle opencode langsung
vim.keymap.set('n', '<leader>ao', function() require('sidekick.cli').toggle { name = 'opencode', focus = true } end, { desc = 'Toggle OpenCode' })

vim.keymap.set('n', '<leader>aa', function() require('sidekick.cli').toggle() end, { desc = 'Sidekick Toggle CLI' })

vim.keymap.set({ 'n', 'x' }, '<leader>at', function() require('sidekick.cli').send { msg = '{this}' } end, { desc = 'Send This' })

vim.keymap.set('n', '<leader>af', function() require('sidekick.cli').send { msg = '{file}' } end, { desc = 'Send File' })

vim.keymap.set('x', '<leader>av', function() require('sidekick.cli').send { msg = '{selection}' } end, { desc = 'Send Visual Selection' })
