vim.pack.add { { src = Gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

local blink_plugins = {
  Gh 'saghen/blink.lib',
  Gh 'saghen/blink.cmp',
}

vim.pack.add(blink_plugins)
local cmp = require 'blink.cmp'

cmp.build():pwait()
cmp.setup {
  keymap = {
    preset = 'enter',
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 100 },
    list = {
      selection = {
        -- auto select
        preselect = true,
        auto_insert = true,
      },
    },
    menu = {
      auto_show = true,
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },

  snippets = { preset = 'luasnip' },

  fuzzy = { implementation = 'rust' },

  signature = { enabled = true },
}
