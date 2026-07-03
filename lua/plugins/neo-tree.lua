vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '<leader>e', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local is_real_file = vim.bo.buftype == '' and bufname ~= '' and vim.fn.filereadable(bufname) == 1
  local in_cwd = is_real_file and vim.startswith(vim.fn.fnamemodify(bufname, ':p:h'), vim.fn.getcwd())

  if is_real_file and in_cwd then
    vim.cmd 'Neotree reveal'
  else
    vim.cmd 'Neotree toggle'
  end
end, { desc = 'NeoTree reveal/toggle', silent = true })

require('neo-tree').setup {
  auto_clean_after_session_restore = true,
  clipboard = {
    sync = 'global',
  },
  close_if_last_window = true,
  default_component_configs = {
    icon = {
      use_filtered_colors = false,
    },
    name = {
      use_filtered_colors = false,
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
    },
    window = {
      width = 30,
      mappings = {
        ['<leader>e'] = 'close_window',
      },
    },
  },
  source_selector = {
    winbar = true,
    statusline = false,
    show_scrolled_off_parent_node = false, -- ini masih full path, kalau bisa tampilkan foldernya saja
    sources = {
      { source = 'filesystem' },
      { source = 'git_status' },
      { source = 'buffers' },
    },
    truncation_character = '…', -- character to use when truncating the tab label
  },
}
