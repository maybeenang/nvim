vim.pack.add { Gh 'windwp/nvim-ts-autotag' }

require('nvim-ts-autotag').setup {
  filetypes = {
    'html',
    'javascript',
    'typescriptreact',
    'javascriptreact',
    'svelte',
    'vue',
    'tsx',
    'jsx',
  },
}
