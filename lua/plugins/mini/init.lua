vim.pack.add { Gh 'nvim-mini/mini.nvim' }

if vim.g.have_nerd_font then
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
end

require 'plugins.mini.starter'
require 'plugins.mini.ai'
require 'plugins.mini.statusline'
require 'plugins.mini.surround'
