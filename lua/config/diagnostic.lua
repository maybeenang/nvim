vim.diagnostic.config {
  update_in_insert = true,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,

  virtual_text = true,
  virtual_lines = false,

  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}
