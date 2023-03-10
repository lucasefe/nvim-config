local group = vim.api.nvim_create_augroup('Custom', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'silent! !chezmoi apply',
  group = group,
  pattern = os.getenv("HOME") .. '/.local/share/chezmoi/**/*'
})
--
-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


