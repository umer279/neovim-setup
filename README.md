# Neovim Setup

## Prerequisites

Install Neovim and utilities:

```bash
brew install neovim
brew install ripgrep
```

## LSP Keymaps

Configure LSP navigation and actions:

```lua
-- Go to Definition
map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")

-- Go to References
map("n", "gr", vim.lsp.buf.references, "LSP: Go to References")

-- Hover Documentation
map("n", "K", vim.lsp.buf.hover, "LSP: Hover Documentation")

-- Code Actions
map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")

-- Rename Symbol
map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename Symbol")

-- Show Diagnostics
map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")
```

## Terminal Keymaps

`Ctrl + \` - open or close terminal

```lua
-- 1. Command for Floating Terminal
    vim.keymap.set('n', '<leader>tf', '<cmd>1ToggleTerm direction=float<cr>', {desc = "Terminal Float"})

    -- 2. Command for Classic (Horizontal) Terminal
    vim.keymap.set('n', '<leader>th', '<cmd>2ToggleTerm direction=horizontal<cr>', {desc = "Terminal Horizontal"})

    -- 3. Command for Vertical (Optional, if you like side-by-side)
    vim.keymap.set('n', '<leader>tv', '<cmd>3ToggleTerm direction=vertical size=60<cr>', {desc = "Terminal Vertical"})
```

## AI Assistant

Require Ollama with `qwen3.5:cloud` model (requires sign-in) or update config in `lua/plugins/codecompanion.lua`:

```bash
:CodeCompanion prompt
:CodeCompanionChat
:CodeCompanionActions
:CodeCompanionCmd
```

> **Note:** The `qwen3.5:cloud` model requires authentication. Sign in to your Ollama account or switch to a local model if preferred.

## Useful Vim Commands

### 1. Delete

- `dw` - delete word
- `de` - delete to end of word
- `d$` - delete to end of line- `dd` - delete line

### 2. Change

- `cw` - change word
- `ce` - change to end of word
- `c$` - change to end of line
- `cc` - change line

### 3. Undo

- `u` - undo
- `U` - redo

### 4. Navigation

- `Ctrl + g` - show current line
- `G` - go to bottom
- `gg` - go to top
- `number + G` - go to specific line

### 5. Paste

- `p` - paste last deleted item

### 6. Matching Parenthesis

- `%` - jump to matching parenthesis

### 7. Search

- `/word` - search forward
- `n` - next match
- `N` - previous match
- `?word` - search backward

### 8. Replace

- `:s/old/new/g` - replace in current line
- `:START,ENDs/old/new/g` - replace in range
- `:%s/old/new/g` - replace all
- `:%s/old/new/gc` - replace with confirmation

### 9. Run Shell Command

- `:!command` - execute shell command

### 10. Save / File Operations

- `:w` - save
- `:w filename` - save as
- `:!rm filename` - delete file

### 11. Visual Selection

- `v` - start selection
- `:w filename` - save selection to new file

### 12. Insert File Content

- `:r FILENAME` - insert file content

### 13. New Lines

- `o` - new line below
- `O` - new line above

### 14. Replace Characters

- `r` - replace one char
- `R` - replace multiple chars

### 15. Copy (Yank)

- `yw` - copy word
- `yy` - copy line

### 16. Case-Insensitive Search

- `/text\c` - ignore case for one search
- `:set ic` - ignore case globally
- `:set hls` - highlight matches
- `:nohlsearch` - remove highlight

### 17. Help

- `:help` - open help
- `:help topic` - open specific help

### 18. New Windows

- `:new` - new horizontal window
- `:vnew` - new vertical window
- `Ctrl + w` - switch window

### 19. Comment Code Blcok

- `gcc` - comment line
- `gc` - comment selection
