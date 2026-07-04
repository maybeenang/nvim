vim.pack.add { Gh 'JulienZD/copilot-statusline.nvim' }

local statusline = require 'mini.statusline'

-- Cache untuk menyimpan status git terakhir dari buffer normal
local last_git = ''
local last_diff = ''

local function section_lsp_names()
  local clients = vim.lsp.get_clients { bufnr = 0 }

  if #clients == 0 then return '' end

  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end

  return '[LSP]' .. table.concat(names, ',')
end

-- filetype only, with icon
local function section_filetype()
  local filetype = vim.bo.filetype
  if filetype == '' then return '' end

  local icon = ''
  if vim.g.have_nerd_font then icon = MiniIcons.get('filetype', filetype) or '' end

  return icon .. ' ' .. filetype
end

-- get formatters from conform
local function section_formatters()
  local formatters = require('conform').list_formatters_for_buffer(0)

  if #formatters == 0 then return '' end

  local formatter_names = {}
  for _, formatter in ipairs(formatters) do
    table.insert(formatter_names, formatter.name)
  end

  return '[FMT]' .. table.concat(formatters, ',')
end

-- get linters from lint
local function section_linters()
  local lint = require 'lint'
  local filetype = vim.bo.filetype

  local linters = lint.linters_by_ft[filetype] or {}

  if #linters == 0 then return '' end

  local linter_names = {}
  for _, linter in ipairs(linters) do
    table.insert(linter_names, linter)
  end

  return '[LINT]' .. table.concat(linter_names, ',')
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

      local copilot = require('copilot-statusline').section_copilot { trunc_width = 75 }

      local lsp = section_lsp_names()
      local formatters = section_formatters()
      local linters = section_linters()

      local fileinfo = section_filetype()

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode:upper() } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
        '%<',
        { hl = 'MiniStatuslineFilename' },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { copilot, lsp, formatters, linters } },
        { hl = mode_hl, strings = { fileinfo } },
      }
    end,
  },
}

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end
