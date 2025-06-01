return {
  "harpoon",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = function()
    local keys = {
      {
        "<Leader>i",
        function()
          require("harpoon"):list():add()
        end,
        desc = "harpoon [i]t",
      },
      {
        "<Leader>fh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "[h]arpoon menu",
      },

      {
        "<C-z>",
        function()
          return require("harpoon"):list():prev()
        end,
        desc = "harpoon [p]rev",
      },
      {
        "<C-x>",
        function()
          return require("harpoon"):list():next()
        end,
        desc = "harpoon [n]ext",
      },
      {
        "[i",
        function()
          return require("harpoon"):list():prev()
        end,
        desc = "harpoon [p]rev",
      },
      {
        "]i",
        function()
          return require("harpoon"):list():next()
        end,
        desc = "harpoon [n]ext",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<Leader>" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to " .. i,
      })
    end

    return keys
  end,
}
