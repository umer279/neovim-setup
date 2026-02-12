vim.opt.nu = true                 -- set line numbers -- set line numbers
vim.opt.relativenumber = true     -- use relative line numbers

vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.shiftwidth = 2    -- Use 2 spaces for indent (standard for Lua)
vim.opt.tabstop = 2       -- A tab counts for 2 spaces
vim.opt.smartindent = true -- Enable smart indentation logic

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear highlighting
