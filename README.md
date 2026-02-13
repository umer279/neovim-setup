# Neovim Setup

## Prerequisites

```
brew install neovim
brew install ripgrep
```

## LSP Keymaps

```lua
map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
map("n", "gr", vim.lsp.buf.references, "LSP: Go to References")
map("n", "K", vim.lsp.buf.hover, "LSP: Hover Documentation")
map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename Symbol")
map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")

vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
```

---

## Useful Vim Commands

### 1. Delete

- `dw`, `de`, `d$`, `dd`

### 2. Change

- `cw`, `ce`, `c$`, `cc`

### 3. Undo

- `u`, `U`

### 4. Navigation

- `Ctrl + g` → show current line
- `G` → go to bottom
- `gg` → go to top
- `number + G` → go to specific line

### 5. Paste

- `p` → paste last deleted item

### 6. Matching Parenthesis

- `%`

### 7. Search

- `/word` → search forward\
- `n` → next match\
- `N` → previous match\
- `?word` → search backward

### 8. Replace

- `:s/old/new/g` → replace in current line\
- `:START,ENDs/old/new/g` → replace in range\
- `:%s/old/new/g` → replace all\
- `:%s/old/new/gc` → replace with confirmation

### 9. Run Shell Command

- `:!command`

### 10. Save / File Operations

- `:w` → save\
- `:w filename` → save as\
- `:!rm filename` → delete file

### 11. Visual Selection

- `v` → start selection\
- then `:w filename` → save selection to new file

### 12. Insert File Content

- `:r FILENAME`

### 13. New Lines

- `o` → new line below\
- `O` → new line above

### 14. Replace Characters

- `r` → replace one char\
- `R` → replace multiple chars

### 15. Copy (Yank)

- `yw` → copy word\
- `yy` → copy line

### 16. Case-Insensitive Search

- `/text\c` → ignore case for one search\
- `:set ic` → ignore case globally\
- `:set hls` → highlight matches\
- `:nohlsearch` → remove highlight

### 17. Help

- `:help` → open help\
- `Ctrl + w` → switch window\
- `:help topic` → open specific help
