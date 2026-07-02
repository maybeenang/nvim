-- NOTE: DASHBOARD
local starter = require 'mini.starter'

local header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

local _start = vim.fn.reltime()
local function footer()
  local elapsed_ms = math.floor(vim.fn.reltimefloat(vim.fn.reltime(_start)) * 1000 + 0.5)
  return string.format('startup time : %dms', elapsed_ms)
end

starter.setup {
  header = header,
  footer = footer,
  items = {
    starter.sections.recent_files(3, false, false),
    starter.sections.builtin_actions(),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet '',
    starter.gen_hook.aligning('center', 'center'),
  },
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniStarterOpened',
  callback = function(ev)
    vim.keymap.set('n', 'j', function() starter.update_current_item('next', ev.buf) end, { buffer = ev.buf, silent = true })
    vim.keymap.set('n', 'k', function() starter.update_current_item('previous', ev.buf) end, { buffer = ev.buf, silent = true })
  end,
})
