require("neo-tree").setup {}
-- make sure to escape \
vim.keymap.set('n', '\\', '<cmd>Neotree toggle current reveal_force_cwd<CR>',
  { desc = "Toggle neotree reveal. Replaces current window like netrw" }
)
vim.keymap.set('n', '|', '<cmd>Neotree reveal<CR>', { desc = "Reveals neotree in the left hand drawer." })
-- kinda cool, but kind of a headache since it changes the cwd
-- vim.keymap.set('n', '<leader>gd', '<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<CR>', { desc = "Opens directory of file under curse in floating pane"})
vim.keymap.set('n', '<leader>b', '<cmd>Neotree toggle show buffers right<CR>', {})
vim.keymap.set('n', '<leader>s', '<cmd>Neotree float git_status<CR>', {})
