local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle harpoon files" })

vim.keymap.set("n", "<C-.>", function() ui.nav_next() end, { desc = "Go to next Harpoon file" })
vim.keymap.set("n", "<C-,>", function() ui.nav_prev() end, { desc = "Go to previous Harpoon file" })
