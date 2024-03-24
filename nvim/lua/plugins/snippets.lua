local concatTables = function(t1, t2)
	for _, v in ipairs(t2) do
		table.insert(t1, v)
	end

	return t1
end

local pascalize = function(str)
	str = str:gsub("[-_.]", " ")

	-- Capitalize first letter of each word
	str = str:gsub("(%a)([%w_]*%s*)", function(first, rest)
		return first:upper() .. rest:lower()
	end)

	return str:gsub("%s", "")
end

local pascalize_filename = function(filename)
	local parts = vim.split(filename, ".", { plain = true })
	filename = filename:sub(1, #filename - #parts[#parts])

	return pascalize(filename)
end

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
					silent = true,
					mode = { "i", "s" },
				},
				{
					"<c-j>",
					function()
						if ls.expand_or_jumpable() then
							ls.expand_or_jump()
						end
					end,
					expr = true,
					silent = true,
					mode = { "s" },
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
			local fmta = require("luasnip.extras.fmt").fmta
			local rep = require("luasnip.extras").rep

			local snippet = ls.s
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local d = ls.dynamic_node
			local c = ls.choice_node
			local sn = ls.snippet_node

			ls.add_snippets("all", {
				snippet(
					"curtime",
					f(function()
						return os.date("%Y-%m-%d %H:%M")
					end)
				),
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
				snippet(
					"trc",
					fmta(
						[[
        try {
          <try>
        } catch (<err_name>) {
          <err>
        }<finish>
        ]],
						{
							try = i(3),
							err_name = i(1, "err"),
							err = c(2, {
								t(""),
								f(function(args)
									return string.format("console.error(%s);", args[1][1])
								end, { 1 }),
							}),
							finish = c(4, {
								t(""),
								sn(
									nil,
									fmta(
										[[
                 finally {
                  <finally>
                }
                ]],
										{ finally = i(1) }
									)
								),
							}),
						}
					)
				),
			}

			ls.add_snippets("javascript", shared_ts_snippets)
			ls.add_snippets("typescript", shared_ts_snippets)

			ls.add_snippets(
				"typescriptreact",
				concatTables(shared_ts_snippets, {
					snippet(
						"rh",
						fmt(
							[[
          const {} = () => {{
            return <div>{}</div>;
          }};
            ]],
							{
								d(1, function(_, parent)
									local filename = parent.snippet.env.TM_FILENAME or ""

									filename = pascalize_filename(filename)

									return sn(nil, {
										i(1, filename),
									})
								end),
								i(0),
							}
						)
					),
					snippet(
						"rhp",
						fmt(
							[[
          interface {}Props {{
            {}
          }}

          const {} = ({}: {}Props) => {{
            return <div>{}</div>;
          }};
          ]],
							{
								d(1, function(_, parent)
									local filename = parent.snippet.env.TM_FILENAME or ""

									filename = pascalize_filename(filename)

									return sn(nil, {
										i(1, filename),
									})
								end),
								i(2),
								rep(1),
								c(3, {
									t("props"),
									sn(nil, fmt("{{ {} }}", { i(1) })),
									sn(nil, fmt("{{ {}, ...props }}", { i(1) })),
								}),
								rep(1),
								i(0),
							}
						)
					),
				})
			)
		end,
	},
}
