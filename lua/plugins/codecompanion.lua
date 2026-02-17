return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		-- 1. Configure how you want to interact with the LLM
		strategies = {
			chat = {
				adapter = "ollama",
			},
			inline = {
				adapter = "ollama",
			},
			cmd = {
				adapter = "ollama",
			},
		},
		-- 2. Define/Extend the Ollama adapter to use your specific model
		adapters = {
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					schema = {
						model = {
							default = "qwen3.5:cloud",
						},
						num_ctx = {
							default = 16384,
						},
						-- Add inline-specific parameters if needed
					},
					-- Ensure the adapter handles inline requests
					inline = function(params)
						return require("codecompanion.adapters").ollama(params)
					end,
				})
			end,
		},
		-- 3. UI and Display settings
		display = {
			action_palette = {
				provider = "telescope", -- Options: telescope, mini_pick, snacks
			},
		},
	},
}
