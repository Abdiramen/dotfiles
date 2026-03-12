vim.opt.clipboard = 'unnamedplus'
vim.g.mapleader = " "
vim.wo.wrap = false
vim.o.visualbell = true
vim.o.cursorline = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.hlsearch = true
vim.o.splitright = true
local csharp_ls = "@csharp-ls@"
local authors = "@authors@"

--vim.api.nvim_create_autocmd("ColorScheme", {
--  callback = function()
--    -- In many languages the comment semantic highlight will overwrite useful treesitter highlights like @text.todo inside comments.
--    vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
--    -- Clangd only sends comment tokens for `#if 0` sections so it doesn't have the problem above.
--    vim.api.nvim_set_hl(0, "@lsp.type.comment.c", { link = "Comment" })
--    vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", { link = "@comment" })
--  end,
--})
