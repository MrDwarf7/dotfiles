-- local wk = require("which-key")
-- wk.add({
--   { "<Leader>h", group = "+[H]unk(s)" },
--   { "<Leader>l", group = "+[L]SP" },
--   { "<Leader>p", group = "+[P]lugins" },
--   { "<Leader>t", group = "+[T]oggles" },
-- })

return {
  "snacks.nvim",
  keys = {
    -- stylua: ignore start
		{ "<Leader>n", false },
		{ "<Leader>un", false },

			{ "<Leader>td", function() local dim = require("snacks").dim if dim.enabled ~= nil and dim.enabled == true then dim.disable() else dim.enable() end end, desc = "Toggle dimming" },
			-- { "<Leader>go", function() local lg = require("snacks").lazygit Snacks.lazygit() end },
			{ "<Leader>t.", function() Snacks.scratch() end, desc = "Toggle Scratch" },
			{ "<Leader>.", function() Snacks.scratch.select() end, desc = "Select Scratch" },
			{ "<Leader>`", function () Snacks.terminal() end, desc = "Open Terminal" },
			{ "<Leader>tn", function ()
				if Snacks.config.picker and Snacks.config.picker.enabled then
					Snacks.picker.notifications()
				else
					Snacks.notifier.show_history()
				end
			end, desc = "Notifications History"},
    -- stylua: ignore end
  },
  opts = function(opts)
    return {
      -- animate = true,
      -- bigfile = true,
      bufdelete = {
        enabled = true,
        notify = true,
        size = 1.5 * 1024 * 1024, -- 1.5 MB
      },
      dashboard = { enable = false },
      dim = { enabled = true, animate = { enabled = false } },
      explorer = { enabled = false },
      indent = {
        enabled = true,
        animate = {
          duration = {
            step = 15,
          },
        },
        -- scope = {
        -- 	char = "▎",
        -- },
        chunk = {
          enabled = true,
          only_current = true,
          char = {
            corner_top = "┌",
            corner_bottom = "└",
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
        blank = {
          char = ">>>",
        },
      },
    }
  end,
}
