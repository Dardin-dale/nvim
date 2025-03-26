require "neovide"
vim.loader.enable()
require "logan.plugins"
require "logan"
-- BEGIN ANSIBLE MANAGED BLOCK - WSL CLIPBOARD
-- WSL clipboard integration
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = true,
  }
end
-- END ANSIBLE MANAGED BLOCK - WSL CLIPBOARD
