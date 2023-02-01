-- Set colorscheme
-- vim.o.termguicolors = true
-- vim.cmd [[colorscheme onedark]]

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha

require("catppuccin").setup()

vim.cmd [[colorscheme catppuccin]]

vim.api.nvim_set_hl(0, 'Comment', { italic=true })

