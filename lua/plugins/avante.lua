return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		provider = "gemini",
		-- NEW STRUCTURE: All Gemini-specific settings go here
		behaviour = {
			auto_suggestions = false, -- ⚠️ CRITICAL: Ghost text sends a request on every keystroke!
			enable_token_counting = false, -- Saves one API call per message
		},
		providers = {
			gemini = {
				model = "gemini-2.5-flash",
				max_tokens = 4096,
				temperature = 0,
			},
		},
		-- These are now top-level behavior settings
		auto_suggestions_provider = "gemini",
		behaviour = {
			auto_suggestions = false,
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
		},
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
