return {
	"nvim-neotest/neotest",
	dependencies = {
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-jest",
	},
	opts = function(_, opts)
		table.insert(opts.adapters, require("neotest-vitest"))

		table.insert(
			opts.adapters,
			require("neotest-jest")({
				-- jestCommand = "npm test --",
				jestCommand = require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h")),
				jestConfigFile = "",
				jest_test_discovery = false,
				env = { CI = true },
				cwd = function()
					return vim.fn.getcwd()
				end,
			})
		)

		opts.discovery = {
			enabled = false,
		}
		return opts
	end,
}
