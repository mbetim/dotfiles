return {
	{
		"rafamadriz/friendly-snippets",
		opts = {
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/snippets" } }),
		},
	},
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			local ls = require("luasnip")

			return {
				{
					"<c-j>",
					function()
						if ls.expand_or_jumpable() then
							ls.expand_or_jump()
						end
					end,
					-- expr = true,
					silent = true,
					mode = { "i", "s" },
				},
				{
					"<c-k>",
					function()
						if ls.jumpable(-1) then
							ls.jump(-1)
						end
					end,
					desc = "Jump to previous snippet",
					silent = true,
					mode = { "i", "s" },
				},
				{
					"<c-l>",
					function()
						if ls.choice_active() then
							ls.change_choice(1)
						end
					end,
					mode = { "i" },
				},
			}
		end,
		opts = function(_, opts)
			opts.updateevents = "TextChanged,TextChangedI"

			local ls = require("luasnip")

			local fmt = require("luasnip.extras.fmt").fmt
			local rep = require("luasnip.extras").rep

			local snippet = ls.s
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local d = ls.dynamic_node
			local sn = ls.snippet_node

			ls.add_snippets("all", {
				snippet(
					"curtime",
					f(function()
						return os.date("%Y-%m-%d %H:%M")
					end)
				),
				snippet("me", t("Betim")),
			})

			ls.add_snippets("lua", {
				snippet(
					"req",
					fmt("local {} = require('{}')", {
						d(2, function(args)
							local parts = vim.split(args[1][1], ".", { plain = true })
							return sn(nil, {
								i(1, parts[#parts] or ""),
							})
						end, { 1 }),
						i(1),
					})
				),

				snippet(
					"lf",
					fmt(
						[[
        local {} = function({})
          {}
        end
        ]],
						{ i(1), i(2), i(0) }
					)
				),
			})

			local shared_ts_snippets = {
				snippet("cod", {
					i(3, "const"),
					t(" { "),
					i(2),
					t(" } = "),
					i(1),
				}),
			}

			ls.add_snippets("javascript", shared_ts_snippets)
			ls.add_snippets("typescript", shared_ts_snippets)
		end,
	},
}
