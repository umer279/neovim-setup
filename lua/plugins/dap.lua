return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dap").providers.configs["dap.launch.json"] = nil

			require("mason-nvim-dap").setup({
				-- Automatically installs the debug adapter
				ensure_installed = { "js-debug-adapter" },
				handlers = {},
			})

			-- UI Setup
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- 1. Define the adapter
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- Mason usually installs it here:
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
			dap.adapters.node = dap.adapters["pwa-node"]

			-- 2. Configure for Javascript/Typescript
			local chimera_config = {
				type = "pwa-node",
				request = "launch",
				name = "Debug Local Tests",
				runtimeExecutable = "npm",
				runtimeArgs = { "run-script", "chimera:web-debug", "--", "${fileBasename}" },
				env = { test_env = "local" },
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				skipFiles = { "<node_internals>/**" },
			}

			dap.configurations.javascript = { chimera_config }
			dap.configurations.typescript = { chimera_config }

			-- Keybindings
			vim.keymap.set("n", "<leader>ds", function()
				dap.continue()
			end, { desc = "Debug: Start" })
			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "Debug: Breakpoint" })
			vim.keymap.set("n", "<leader>do", function()
				dap.step_over()
			end, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<leader>dr", function()
				dap.restart()
			end, { desc = "Debug: Restart" })
			vim.keymap.set("n", "<leader>dq", function()
				dap.terminate()
				require("dapui").close()
			end, { desc = "Debug: Terminate session" })
		end,
	},
}
