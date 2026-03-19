vim.opt.nu = true -- set line numbers -- set line numbers
vim.opt.relativenumber = true -- use relative line numbers

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2 -- Use 2 spaces for indent (standard for Lua)
vim.opt.tabstop = 2 -- A tab counts for 2 spaces
vim.opt.smartindent = true -- Enable smart indentation logic

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlighting

vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")

-- Jump to the next diagnostic (Error/Warn/Info)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
-- Jump to the previous diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

-- Delete all buffers
vim.keymap.set("n", "<leader>ba", ":%bd<CR>", { desc = "Delete all buffers" })
-- Delete all buffers EXCEPT the current one
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Delete other buffers" })
