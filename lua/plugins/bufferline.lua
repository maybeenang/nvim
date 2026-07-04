vim.pack.add { Gh 'akinsho/bufferline.nvim' }
require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp',
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    separator_style = 'thin',
    always_show_bufferline = true,
    offsets = {
      {
        filetype = 'neo-tree',
        text = 'File Explorer',
        text_align = 'left',
      },
    },
  },
}
