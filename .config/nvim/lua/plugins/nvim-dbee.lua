return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    -- stylua: ignore start
    { "<Leader>do", function() require("dbee").open() end, desc = "[o]pen the database view" },
    { "<Leader>dc", function() require("dbee").close() end, desc = "[c]lose the database view" },
    { "<Leader>dt", function() require("dbee").toggle() end, desc = "[t]oggle the database view" },
    { "<Leader>de", function(query) require("dbee").execute(query) end, desc = "[e]xecute a database query" },
    { "<Leader>ds", function(format, output, opts) require("dbee").store(format, output, opts) end, desc = "[s]tore a database query" },
    -- stylua: ignore end
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  --@type dbee.Config
  opts = {
    extra_helpers = {

      ["postgres"] = {
        ["List All"] = "select * from {{ .Table }}",
      },
      ["mysql"] = {
        ["List All"] = "select * from {{ .Table }}",
      },
    },
    result = {
      focus_result = false,
    },
  },
  -- config = function(_, opts)
  --   require("dbee").setup(opts)
  -- end,
}
