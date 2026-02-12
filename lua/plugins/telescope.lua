return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local fb_actions = require("telescope").extensions.file_browser.actions
    
    require("telescope").setup({
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
      },
    })
    -- Load the extension after setup
    require("telescope").load_extension("file_browser")
    
    -- Add a keymap so you can actually open it
    vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
    vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
  end,
}
