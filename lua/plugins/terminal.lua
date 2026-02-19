return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]], -- Default toggle (usually opens the last used)
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			close_on_exit = true,
		})

		-- 1. Command for Floating Terminal
		vim.keymap.set("n", "<leader>tf", "<cmd>1ToggleTerm direction=float<cr>", { desc = "Terminal Float" })

		-- 2. Command for Classic (Horizontal) Terminal
		vim.keymap.set("n", "<leader>th", "<cmd>2ToggleTerm direction=horizontal<cr>", { desc = "Terminal Horizontal" })

		-- 3. Command for Vertical (Optional, if you like side-by-side)
		vim.keymap.set(
			"n",
			"<leader>tv",
			"<cmd>3ToggleTerm direction=vertical size=60<cr>",
			{ desc = "Terminal Vertical" }
		)
	end,
}
