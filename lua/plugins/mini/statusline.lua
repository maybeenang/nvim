-- NOTE: STATUS LINE
local statusline = require 'mini.statusline'

-- Cache untuk menyimpan status git terakhir dari buffer normal
local last_git = ''
local last_diff = ''

local function section_lsp_names()
  local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
  local clients = get_clients { bufnr = 0 }

  if #clients == 0 then return '' end

  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end

  return '󰌘 ' .. table.concat(names, ', ')
end

statusline.setup {
  use_icons = vim.g.have_nerd_font,
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }

      local git = MiniStatusline.section_git { trunc_width = 40 }
      local diff = MiniStatusline.section_diff { trunc_width = 75 }

      if vim.bo.buftype == '' or vim.bo.buftype == 'acwrite' then
        last_git = git
        last_diff = diff
      else
        git = last_git
        diff = last_diff
      end

      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      local lsp = section_lsp_names()
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      local location = MiniStatusline.section_location { trunc_width = 75 }
      local search = MiniStatusline.section_searchcount { trunc_width = 75 }

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode:upper() } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
        '%<',
        { hl = 'MiniStatuslineFilename' },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { lsp, fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      }
    end,
  },
}

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end
