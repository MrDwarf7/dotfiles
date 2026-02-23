local keymaps = require("config.keymaps")

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    -- vim.highlight.on_yank({ timeout = 55 })
    vim.hl.on_yank({ timeout = 55 })
  end,
})

-- Nvim tree sitter impl. being turned on
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "<filetype>" },
  callback = function(ctx)
    vim.treesitter.start(ctx.buf, ctx.file)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitconfig", ".gitconfig" },
  callback = function()
    local comment_str = vim.filetype.get_option("gitconfig", "commentstring")
    if comment_str ~= "#" then
      vim.cmd([[ setlocal commentstring=#\ %s ]])
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { ".gitignore_global", ".gitignore_local", ".gitignore.local", ".gitignore.global" },
  callback = function()
    vim.cmd([[ set ft=gitignore ]])
    -- vim.bo.filetype = "gitignore"
  end,
})

--- Use 'q' to close quickfix, jumplist, and other help buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "neotest",
    "neotest-output",
    "qf",
    "help",
    "checkhealth",
    "jumplist",
    "lspinfo",
  },
  callback = function()
    -- keymaps.map("n", "q", "<CMD>close<CR>")
    vim.keymap.set("n", "q", function()
      vim.api.nvim_buf_delete(0, { force = true })
    end, { silent = true, buffer = true })
    -- "<CMD>bd<CR>", { silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function(_)
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype

    local lint_ok, err = pcall(require, "lint")
    if not lint_ok then
      require("utils").output.warn("Linting failed to run: " .. err)
      return
    end

    local lint = require("lint")
    local linters = require("lang_tables").by_ft("force", "linters", {}) -- or { "" }

    if type(linters) == "nil" then
      vim.notify("No linters found for filetype " .. vim.bo.filetype, "warn")
      return
    end

    lint.linters_by_ft = linters
    pcall(lint.try_lint)
    -- lint.try_lint()

    -- You can call `try_lint` with a linter name or a list of names to always
    -- run specific linters, independent of the `linters_by_ft` configuration
    -- require("lint").try_lint("cspell")
  end,
})

-- Renaming files inside of Oil uses Snacks to propagate the changes to LSP refs
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions[1].type == "move" then
      Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
    end
  end,
})

----------------------
--- Very cool LSP spinner thing
----------------------

-- ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
-- local progress = vim.defaulttable()
-- vim.api.nvim_create_autocmd("LspProgress", {
--   ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
--     if not client or type(value) ~= "table" then
--       return
--     end
--     local p = progress[client.id]
--
--     for i = 1, #p + 1 do
--       if i == #p + 1 or p[i].token == ev.data.params.token then
--         p[i] = {
--           token = ev.data.params.token,
--           msg = ("[%3d%%] %s%s"):format(
--             value.kind == "end" and 100 or value.percentage or 100,
--             value.title or "",
--             value.message and (" **%s**"):format(value.message) or ""
--           ),
--           done = value.kind == "end",
--         }
--         break
--       end
--     end
--
--     local msg = {} ---@type string[]
--     progress[client.id] = vim.tbl_filter(function(v)
--       return table.insert(msg, v.msg) or not v.done
--     end, p)
--
--     local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--     ---@diagnostic disable-next-line: param-type-mismatch
--     vim.notify(table.concat(msg, "\n"), "info", {
--       id = "lsp_progress",
--       title = client.name,
--       opts = function(notif)
--         notif.icon = #progress[client.id] == 0 and " "
--           or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
--       end,
--     })
--   end,
-- })
--

-- Handles in `config.lsp`
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(event)
--     local buf_name = vim.api.nvim_buf_get_name(0)
--     if string.find(buf_name, ".obsidian.vimrc") then
--       vim.api.nvim_buf_set_option(0, "filetype", "vim")
--       return
--     end
--     -- if client and client.server_capabilities.documentHighlightProvider then
--     --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--     --     buffer = event.buf,
--     --     callback = vim.lsp.buf.document_highlight,
--     --   })
--     --
--     --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--     --     buffer = event.buf,
--     --     callback = vim.lsp.buf.clear_references,
--     --   })
--     -- end
--   end,
-- })
