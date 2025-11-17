vim.opt.clipboard = 'unnamedplus'
vim.wo.wrap = false
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
