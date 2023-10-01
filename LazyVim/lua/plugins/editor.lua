local Util = require("lazyvim.util")
-- local which_key_autoload = false

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  keys = {
    {
      "<leader>/", -- buffer fuzzy find, from "leader sb"
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end,
      desc = "Search in buffer",
    },

    --------------------------------------------------------------------------
    -- Add New Keybindings
    --------------------------------------------------------------------------
    keys = {
      {
        "<leader>f",
        { desc = "[f]ind" },
      },
      {
        "<leader><space>",
        false,
        "<leader>fr",
        function()
          Util.telescope("oldfiles", { cwd = vim.loop.cwd() })()
        end,
        desc = "[f]ind [r]ecents",
      },

      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "[f]ind [f]iles",
      },

      {
        "<leader>fw",
        function()
          require("telescope.builtin").live_grep(
            { word_match = "-w" },
            { cwd = require("lazy.core.config").options.root }
          )
        end,
        desc = "[f]ind words",
      },
      {
        function()
          require("telescope.builtin").grep_string(
            { word_match = "-w" },
            { cwd = require("lazy.core.config").options.root }
          )
        end,
        desc = "[f]ind [s]tring",
      },

      {
        "<leader>fb",
        "<cmd>Telescope buffers<cr>",
        {},

        "<leader>ff",
        function()
          require("telescope.builtin").buffer({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "[f]ind [b]uffer",
      },

      {
        "<leader>fm",
        function()
          require("telescope.builtin").marks({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "[f]ind [m]arks",
      },

      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "[f]ind [h]elp",
      },

      {
        "<leader>ft",
        function()
          require("telescope.builtin").treesitter()
        end,
        desc = "[f]ind [t]reesitter symbols",
      },
      mappings = {
        i = {
          ["<C-n>"] = require("telescope.builtin").cycle_history_next,
          ["<C-p>"] = require("telescope.builtin").cycle_history_prev,
          ["<C-k>"] = require("telescope.builtin").cycle_history_next, -- TODO: Conflicting keymap
          ["<C-j>"] = require("telescope.builtin").cycle_history_prev, -- TODO: Conflicting keymap
        },
        n = {
          ["q"] = require("telescope.builtin").close,
        },
      },
    },
  },
}
