return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Load when you open a file
	opts = {
		formatters_by_ft = {
			-- Use prettier for yaml, json, html, etc.
			typescript = { "prettierd" },
			javascript = { "prettierd" },
			yaml = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
			-- You can add more as needed
		},
		-- This part is key: it formats automatically when you save
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback", -- Use LSP if prettier isn't available
		},
	},
}
