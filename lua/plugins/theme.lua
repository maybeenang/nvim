vim.pack.add { { src = Gh 'catppuccin/nvim', name = 'catppuccin' } }
require('catppuccin').setup {
  flavour = 'mocha',
  integrations = {
    telescope = true,
    nvimtree = true,
    notify = true,
    which_key = true,
    gitsigns = true,
    mason = true,
    hop = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { 'undercurl' },
        warnings = { 'undercurl' },
        hints = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
  },
  highlight_overrides = {
    all = function(colors)
      return {
        DiagnosticUnderlineError = { sp = colors.red, undercurl = true },
        DiagnosticUnderlineWarn = { sp = colors.yellow, undercurl = true },
        DiagnosticUnderlineHint = { sp = colors.teal, undercurl = true },
        DiagnosticUnderlineInfo = { sp = colors.sky, undercurl = true },
        -- NvimTreeDiagnosticErrorFileHL = { fg = colors.red },
        -- NvimTreeDiagnosticWarnFileHL = { fg = colors.yellow },
        -- NvimTreeDiagnosticInfoFileHL = { fg = colors.sky },
        -- NvimTreeDiagnosticHintFileHL = { fg = colors.teal },
        --
        -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorFileHL", { fg = "#f44747" })
        -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarnFileHL", { fg = "#cca700" })
        -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfoFileHL", { fg = "#75beff" })
        -- vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHintFileHL", { fg = "#b5cea8" })
      }
    end,
  },
}
vim.cmd.colorscheme 'catppuccin-mocha'

vim.pack.add { Gh 'folke/tokyonight.nvim' }
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}
