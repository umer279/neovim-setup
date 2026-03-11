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

## DAP Keymaps

```lua
-- The "Navigation" Group
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: [C]ontinue" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug: [N]ext (Step Over)" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step [I]nto" })
vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: Step [U]p/Out" })

-- The "Setting" Group
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle [B]reakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = "Debug: Set Conditional [B]reakpoint" })

-- The "Control" Group
vim.keymap.set("n", "<leader>dx", function()
    dap.terminate()
    require("dapui").close()
end, { desc = "Debug: [X] Terminate" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open [R]EPL" })
vim.keymap.set('n', '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, { desc = "Debugger Hover" })
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = "Debugger Scopes" })
```

## AI Assistant

Requires GEMINI_API_KEY or chenge the model from `plugins/avante.lua`

### ⌨️ Avante.nvim Quick Reference (2026)

#### 🚀 Core Actions
| Key | Mode | Action |
| :--- | :--- | :--- |
| `<leader>aa` | Normal | **Toggle Chat**: Open/Close the AI sidebar. |
| `<leader>ae` | Visual | **Inline Edit**: Highlight code + ask for changes. |
| `<leader>af` | Normal | **Focus**: Jump cursor into the chat window. |
| `<leader>ar` | Normal | **Refresh**: Clear chat history (reset memory). |

---

#### 🛠️ The Diff Workflow (Applying Changes)
When you use `<leader>ae`, Gemini shows a "Diff". Use these to handle it:

* **`<leader>au`** : **Accept** — Apply the AI's change to your code.
* **`<leader>an`** : **Reject** — Discard the AI's change.
* **`co`** : **Choose Ours** — Keep your original line in a conflict.
* **`ct`** : **Choose Theirs** — Keep the AI's line in a conflict.

---

#### 💬 Inside the Chat Window
| Key | Action |
| :--- | :--- |
| **`Ctrl + s`** | **Submit**: Send your message to Gemini. |
| **`Tab`** | Cycle focus between Input box and History. |
| **`@`** | **Mention**: Add specific files to the context. |
| **`[[` / `]]`** | Jump between code blocks in the conversation. |
| **`q`** | Close the sidebar immediately. |

---

#### ⚠️ Pro-Tips
1. **Submit via Ctrl+S:** In the inline edit box (`<leader>ae`), pressing Enter usually just adds a new line. You **must** use `Ctrl + s` to send the command.
2. **Context Matters:** Type `@` in the chat to pick files from your project. This helps Gemini understand how your functions interact with other files.
3. **Rate Limits:** If you see "Rate limit reached," wait 10 seconds. Gemini 2.0 Flash (Free) allows roughly 10-15 requests per minute.

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
- `[[` - jump back block/class
- `]]` - jump forward blick/class
- `[m` - jump back function
- `]m` - jump forward function
- `f{char}` - Jump forward and land directly on the next occurrence of {char}
- `t{char}` - Jump forward and land until (just before) the next {char}
- `F{char} / T{char}` - The same as above, but moving backward.
- `;` - Repeat the last f, t, F, or T jump. This is a massive time-saver.
- `e` - Jump to the end of the next word
- `b` - Jump backward to the start of the word
- `^` - First non-blank character (perfect for indented code)
- `g_` - Last non-blank character of the line (ignores trailing spaces).

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
