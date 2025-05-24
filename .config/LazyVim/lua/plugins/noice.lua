return {
  "noice.nvim",
  -- stylua: ignore start
  keys = {
    { "<leader>sn", false },
    { "<leader>snl", false },

    { "<leader>snh", false },
    { "<leader>sna", false } ,
    { "<leader>snd", false },
    { "<leader>snt", false },

    { "<leader>n", "", desc = "+[N]otifications"},

		--- ?????????????
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },

    { "<leader>nl", function() require("noice").cmd("last") end, desc = "Last Message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>nn", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>nf", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },

    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},


  -- stylua: ignore end
  },
	-- DOC BORDER
  opts = {
    presets = {
      lsp_doc_border = true,
    },
  },
}
