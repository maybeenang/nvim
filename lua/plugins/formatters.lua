vim.pack.add { Gh 'stevearc/conform.nvim' }
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    typescript = { 'prettierd', stop_after_first = true },
    typescriptreact = { 'prettierd', stop_after_first = true },
    go = {
      'gofmt',
      'goimports-reviser',
      'golines',
    },
  },
  formatters = {
    ['goimports-reviser'] = {
      command = 'goimports-reviser',
      args = { '-rm-unused', '-set-alias', '-format', '$FILENAME' },
      stdin = false,
    },
  },
  notify_on_error = true,
  format_after_save = function(bufnr)
    local enabled_filetypes = {
      lua = true,
      typescript = true,
      typescriptreact = true,
      go = true,
      php = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return {
        lsp_fallback = true,
        async = true,
        timeout_ms = 500,
        quiet = true,
      }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range, quite = true }
end, { range = true })
