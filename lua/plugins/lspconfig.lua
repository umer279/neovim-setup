return {
  -- 1. Mason for managing binaries
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { "prettierd", "eslint_d" }, -- Optional: formatters/linters
    },
  },

  -- 2. LSP Config & Mason Bridge
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls" }, -- Ensure the base server is there
      })
    end,
  },

  -- 3. The "Powerhouse" TypeScript Plugin
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      -- This line is crucial for limiting "too many suggestions" 
      -- and making sure snippets don't error out.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("typescript-tools").setup({
        capabilities = capabilities,
        settings = {
          -- Filter out noise: don't suggest internal Node.js stuff unless needed
          expose_as_code_action = "all",
          complete_function_calls = false, -- Set to false if you want less noise
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayVariableTypeHints = true,
            -- This helps limit suggestions to things actually in your project
            includeCompletionsForModuleExports = true,
          },
        },
      })

      local opts = { noremap = true, silent = true }

      -- Helper function to make it cleaner
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
      end

      map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
      map("n", "gr", vim.lsp.buf.references, "LSP: Go to References")
      map("n", "K", vim.lsp.buf.hover, "LSP: Hover Documentation")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
      map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename Symbol")
      map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")
    end,
  },
}
