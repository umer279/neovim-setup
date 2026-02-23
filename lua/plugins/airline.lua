return {
	{
		"vim-airline/vim-airline",
		dependencies = { "vim-airline/vim-airline-themes" },
		config = function()
			-- Optional: Set the theme within the config function
			vim.g["airline_theme"] = "dark"
			-- Enable smart tab line
			vim.g["airline#extensions#tabline#enabled"] = 1
		end,
	},
}
