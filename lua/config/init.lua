local configs_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'config')
for file_name, type in vim.fs.dir(configs_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('config.' .. module)
  end
end
