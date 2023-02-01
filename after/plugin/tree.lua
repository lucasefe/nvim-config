-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
--
-- OR setup with some options
require("nvim-tree").setup({
  reload_on_bufenter = false,
  sync_root_with_cwd = true,
  disable_netrw = true,
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})


vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, desc = "Toggle tree explorer"})
