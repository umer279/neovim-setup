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
			-- The "Navigation" Group
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: [C]ontinue" })
			vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug: [N]ext (Step Over)" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step [I]nto" })
			vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: Step [U]p/Out" })
			-- The "Setting" Group
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle [B]reakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional [B]reakpoint" })
			-- The "Control" Group
			vim.keymap.set("n", "<leader>dx", function()
				dap.terminate()
				require("dapui").close()
			end, { desc = "Debug: [X] Terminate" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open [R]EPL" })
			vim.keymap.set("n", "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Debugger Hover" })
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "Debugger Scopes" })
		end,
	},
}
