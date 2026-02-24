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

			-- Adapters
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			-- Launch Configs
			local chimera_config = {
				type = "pwa-node",
				request = "launch",
				name = "Debug Chimera Tests",
				runtimeExecutable = "npm",
				runtimeArgs = { "run-script", "chimera:web-debug", "--", "${fileBasename}" },
				env = function()
					local env_input = vim.fn.input("Target Environment (default: local): ")
					if env_input == "" then
						env_input = "local"
					end
					return { test_env = env_input }
				end,
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				skipFiles = { "<node_internals>/**" },
			}

			local catalog_script_config = {
				type = "pwa-node",
				request = "launch",
				name = "Debug Catalog Script",
				skipFiles = { "<node_internals>/**" },
				cwd = "${workspaceFolder}/scripts",
				program = "${workspaceFolder}/scripts/src/main.ts",
				runtimeArgs = {
					"--experimental-strip-types",
					"--env-file=../.env",
				},
				env = {
					FASTIFY_AUTOLOAD_TYPESCRIPT = "1",
				},
				console = "integratedTerminal",
			}

			dap.configurations.javascript = { chimera_config, catalog_script_config }
			dap.configurations.typescript = { chimera_config, catalog_script_config }

			-- Keybindings
			vim.keymap.set("n", "<leader>dc", function()
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
			vim.keymap.set("n", "<leader>dt", function()
				dap.terminate()
				require("dapui").close()
			end, { desc = "Debug: Terminate session" })
		end,
	},
}
