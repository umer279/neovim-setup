return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		local fb_actions = require("telescope").extensions.file_browser.actions

		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".DS_Store",
					".git/",
				},
			},
			extensions = {
				file_browser = {
					theme = "ivy",
					hijack_netrw = true,
					hidden = true,
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
		vim.keymap.set("n", "<leader>ff", function()
			require("telescope.builtin").find_files({
				hidden = true,
				no_ignore = true,
			})
		end)
		-- "Deep" search (finds EVERYTHING)
		vim.keymap.set("n", "<leader>fa", function()
			require("telescope.builtin").find_files({
				hidden = true,
				no_ignore = true,
				file_ignore_patterns = {}, -- This clears the global ignores for this call only
			})
		end)
	end,
}
