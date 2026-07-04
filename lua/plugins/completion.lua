vim.pack.add { { src = Gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' }, { src = Gh 'rafamadriz/friendly-snippets' } }
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip').setup {}

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    local ls_ok, ls = pcall(require, 'luasnip')
    if ls_ok and ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then ls.unlink_current() end
  end,
})

local blink_plugins = {
  Gh 'saghen/blink.lib',
  Gh 'saghen/blink.cmp',
  Gh 'onsails/lspkind.nvim',
}

vim.pack.add(blink_plugins)

local lspkind = require 'lspkind'
lspkind.init { preset = 'codicons' }

local cmp = require 'blink.cmp'

cmp.build():pwait()
cmp.setup {
  keymap = {
    preset = 'enter',
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<Tab>'] = {
      function()
        if require('sidekick').nes_jump_or_apply() then return true end
      end,
      function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept()
          return true
        end
      end,
      'snippet_forward',
      'fallback',
    },
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 0,
      window = {
        border = 'single',
        direction_priority = {
          menu_north = { 'e' },
          menu_south = { 'e' },
        },
        max_height = 10,
        max_width = 40,
      },
    },
    list = {
      selection = {
        -- auto select
        preselect = true,
        -- doesn't disturb when move selection, bcs we set menu.draw.align_to = 'cursor'
        auto_insert = false,
      },
    },
    menu = {
      auto_show = true,
      draw = {
        align_to = 'cursor',
        padding = 0,
        gap = 1,
        treesitter = { 'lsp' },
        columns = { { 'kind_icon' }, { 'label', 'label_description' } },
        components = {
          kind_icon = {
            text = function(ctx)
              if ctx.source_name ~= 'Path' then return (require('lspkind').symbol_map[ctx.kind] or '') .. ctx.icon_gap end

              local is_unknown_type = vim.tbl_contains({ 'link', 'socket', 'fifo', 'char', 'block', 'unknown' }, ctx.item.data.type)
              local mini_icon, _ = require('mini.icons').get(is_unknown_type and 'os' or ctx.item.data.type, is_unknown_type and '' or ctx.label)

              return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
            end,

            highlight = function(ctx)
              if ctx.source_name ~= 'Path' then return ctx.kind_hl end

              local is_unknown_type = vim.tbl_contains({ 'link', 'socket', 'fifo', 'char', 'block', 'unknown' }, ctx.item.data.type)
              local mini_icon, mini_hl = require('mini.icons').get(is_unknown_type and 'os' or ctx.item.data.type, is_unknown_type and '' or ctx.label)
              return mini_icon ~= nil and mini_hl or ctx.kind_hl
            end,
          },
          kind = {
            ellipsis = false,
            width = { fill = true },
            text = function(ctx) return ctx.kind end,
            highlight = function(ctx) return ctx.kind_hl end,
          },
          label = {
            width = { fill = true, max = 60 },
            text = function(ctx) return ctx.label .. ctx.label_detail end,
            highlight = function(ctx)
              local highlights = {
                { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
              }
              if ctx.label_detail then table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' }) end
              for _, idx in ipairs(ctx.label_matched_indices) do
                table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
              end
              return highlights
            end,
          },
          label_description = {
            width = { fill = false },
            text = function(ctx) return ctx.label_description end,
            highlight = 'BlinkCmpLabelDescription',
          },
        },
      },
    },
  },
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'snippets', 'buffer', 'path', 'omni' },
    providers = {
      snippets = {
        max_items = 5,
      },
      buffer = {
        max_items = 5,
        opts = {
          get_bufnrs = function()
            return vim.tbl_filter(function(bufnr) return vim.bo[bufnr].buftype == '' end, vim.api.nvim_list_bufs())
          end,
        },
      },
    },
  },
  fuzzy = { implementation = 'rust' },
  signature = { enabled = true, window = { border = 'single', show_documentation = true } },

  cmdline = {
    enabled = true,
    keymap = {
      preset = 'cmdline',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
    },
    completion = {
      menu = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      ghost_text = { enabled = true },
    },
    sources = {
      default = function()
        local type = vim.fn.getcmdtype()
        -- Search cmdline (/ atau ?)
        if type == '/' or type == '?' then return { 'buffer' } end
        -- Command cmdline (:)
        if type == ':' or type == '@' then return { 'cmdline' } end
        return {}
      end,
    },
  },
}
