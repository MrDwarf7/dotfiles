return {

	"gelguy/wilder.nvim",
	event = "CmdlineEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{ "romgrk/fzy-lua-native", build = "make" },
		"nixprime/cpsm",
	},

	config = function()
		local wilder = require("wilder") -- wildmenu improved

		wilder.setup({
			modes = { ":", "/", "?" },
			next_key = "<Tab>",
			prev_key = "<S-Tab>",
			accept_key = "<Down>",
			reject_key = "<Up>",
			use_vim_remote_plugin = false,
			num_workers = 4,
		})

		wilder.set_option("use_python_remote_plugin", 0)

		wilder.set_option("pipeline", {
			wilder.branch(
				wilder.substitute_pipeline({
					fuzzy = 1,
					fuzzy_filter = wilder.lua_fzy_filter(),
					debounce = 10,
				}),

				wilder.cmdline_pipeline({
					fuzzy = 1,
					fuzzy_filter = wilder.lua_fzy_filter(),
					debounce = 10,
				}),

				wilder.vim_search_pipeline()
			),
		})

		wilder.set_option(
			"renderer",
			wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
				pumblend = 10,
				highlighter = { wilder.pcre2_highlighter(), wilder.lua_fzy_highlighter() },
				highlights = {
					border = "Normal",
					accent = wilder.make_hl("WilderAccent", "Pmenu", {
						{
							a = 1,
						},
						{
							a = 1,
						},
						{
							foreground = "#f4468f",
						},
					}),
				},
				border = "single",
				left = {
					" ",
					wilder.popupmenu_devicons(),
					wilder.popupmenu_buffer_flags({
						flags = "a+",
						icons = { ["+"] = "$", a = ">", h = "#" },
					}),
				},
				right = { " ", wilder.popupmenu_scrollbar() },
				empty_message = wilder.popupmenu_empty_message_with_spinner(),
				["/"] = wilder.wildmenu_renderer({
					highlighter = wilder.lua_fzy_highlighter(),
				}),
			}))
		)

		vim.cmd([[
    cmap <expr> <C-j> wilder#in_context() ? wilder#next() : "\<C-j>"
    cmap <expr> <C-k> wilder#in_context() ? wilder#previous() : "\<C-k>"
    cmap <expr> <C-n> wilder#in_context() ? wilder#next() : "\<C-n>"
    cmap <expr> <C-p> wilder#in_context() ? wilder#previous() : "\<C-p>"
    ]])
	end,
}
