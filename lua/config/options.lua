do
  vim.g.have_nerd_font = true

  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.mouse = 'a'
  vim.o.showmode = false

  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  vim.o.breakindent = true

  vim.o.undofile = true
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  vim.o.updatetime = 100
  vim.o.timeoutlen = 300

  vim.o.splitright = true
  vim.o.splitbelow = true

  -- vim.o.list = true
  -- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  vim.o.inccommand = 'split'

  vim.o.cursorline = true

  -- Menjadikan statusline penuh/global
  vim.o.laststatus = 3

  vim.o.scrolloff = 10

  vim.o.confirm = true

  -- indentation
  vim.o.tabstop = 2
  vim.o.shiftwidth = 2
  vim.o.softtabstop = 2
  vim.o.expandtab = true
  vim.o.smartindent = true
  vim.o.autoindent = true
  vim.o.wrap = false
end
