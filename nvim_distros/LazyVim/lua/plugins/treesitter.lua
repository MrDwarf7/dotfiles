return {
	"nvim-treesitter/nvim-treesitter",

	opts = {
		ensure_installed = {
			"cpp",
			"c_sharp",
			"css",
			"embedded_template",
			"json",
			"scss",
		},

		highlight = {
			enable = true,
		},

		indent = {
			disable = function(lang, buf)
				local indent_disabled = {
					"html",
					"javascript",
					"typescript",
					"css",
					"rust",
				}
				if lang == vim.tbl_keys(indent_disabled) then
					return true
				end
			end,
			enable = true,
		},

		autotag = {
			enable = true,
		},

		-- ---- These seem to break loading into nvim in Windows
		-- sync_install = true,
		-- auto_install = true,

		textobjects = {
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = { expr = true, query = "@function.outer", desc = "Select around function" },
					["if"] = { expr = true, query = "@function.inner", desc = "Select inner function" },
					["ac"] = { expr = true, query = "@class.outer", desc = "Select around function" },
					-- You can optionally set descriptions to the mappings (used in the desc parameter of
					-- nvim_buf_set_keymap) which plugins like which-key display
					["ic"] = { expr = true, query = "@class.inner", desc = "Select inner part of a class region" },
					-- You can also use captures from other query groups like `locals.scm`
					["as"] = { expr = true, query = "@scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = false,
			},
			lsp_interop = {
				enable = true,
				border = "single",
				floating_preview_opts = {},
				peek_definition_code = {
					["<leader>lE"] = "@function.outer",
					["<leader>le"] = "@class.outer",
				},
			},
		},
	},
}
