---@meta
---@module 'utils.t'
---
---
---
---@class MsgData: unknown|vim.SystemCompleted
---


---
---@alias QfTypes "q"|"l"
---


---@class utils.Output
--- `true` if the current Neovim version is `nvim-0.11`, otherwise `false`
---@field __HAS_NVIM_011 boolean
--
--
-- removed --- Set to the same value as `__IS_WIN`, but used to determine if snacks should be used.
--
-- removed ---@field __USE_SNACKS boolean
--
--
--- An info function that notifies messages, aware of fast events
---@field info fun(msg: MsgData|unknown): nil
--- A warning function that notifies messages, aware of fast events
---@field warn fun(msg: MsgData): nil
--- An err function that notifies messages, aware of fast events
---@field err fun(msg: MsgData): nil
--- Check if the current user is root (uid 0) (and not self.___IS_WIN, because, well... Windows)
---@field is_root fun(): boolean
--- Get the development directory, handles expanding the local variable
--- of DEV_DIR, with addational DEV_DIR_NAME appended to it.
--- These (at current) expand and handle both variations of [dD]ocuments:
--- `$HOME/Documents/nvim_dev` or `$HOME/documents/nvim_dev`.
---@field get_dev_dir fun(): string
--- Check if the provided path is a development directory,
--- uses `utils.Generic.get_dev_dir()` internally
---@field is_dev fun(path: string): boolean
--- Checks if a valid `C` compiler is available.
--- Checks against `cc`, `gcc`, `clang`, `cl`, and `zig`.
---@field have_compiler fun(): boolean
--- Checks if the `cargo` command has a nightly version available.
--- Uses `+nightly` to check.
---@field cargo_has_nightly fun(): boolean
--- Get the root of a git repository,
--- or the parent directory if no git repo is found.
---@field git_root fun(cwd: string?, noerr?: boolean): string?, integer?
--- Modify the current working directory to the provided path,
--- or to the parent directory of the current buffer if no path is provided.
---@field set_cwd fun(pwd: string?): nil
--- Get's the current visual selection,
--- or the last known visual selection if not in visual mode.
---@field get_visual_selection fun(nl_literal: boolean?): string
--- Find all quickfix or loclist windows,
--- depending on the type passed.
--- Print a string to the clipboard using OSC 52 (OSC 25).
---@field osc25printf fun(...: string): nil
--- Unload Lua modules matching the provided patterns.
---@field unload_modules fun(patterns: { mod: string, fn?: fun() }): nil
--- Reloads the the predefined config modules.
--- Patterns are already supplied inside this module (`utils.generic`)
--- @see utils.Generic.reload_config for the patterns used.
---@field reload_config fun(): nil
--- Check if a window is a floating window.
---@field win_is_float fun(winnr: number): boolean
--- Calls an input function, either `vim.ui.input` or `vim.fn.input`, depending on the Neovim version.
---@field input fun(prompt: string): string | nil
--- Version specific implementation of retreiving LSP clients.
--- If `nvim-0.11` is available, uses `vim.lsp.get_clients(opts)`
--- If not, fallback to loading clients into a local `via vim.lsp.buf_get_clients(opts.bufnr)`
--- Then setting the metatable for `supports_method`, `request`, and `request_sync`
---@field lsp_get_clients fun(opts: { bufnr?: number, id?: number }): vim.lsp.Client[]
-- local M = {}



-- TODO: @types

---@class utils.Arch
--- `true` if the current OS is Windows, otherwise `false`
--- Checks both `vim.fn.has("win32")` and `has("win64")` versions.
---@field __IS_WIN boolean
---@field get_os fun(): EOperatingSystemEnum
---@field get_os_lower fun(): EOperatingSystemEnumLower


---@class utils.Sudo
--- Execute a command with `sudo`,
--- prompting for the password if necessary.
---@field sudo_exec fun(cmd: string, print_output?: boolean): boolean
--- Execute a write command using `dd` and pre-set bytesize,
--- using `sudo` to write to the file.
---
--- Uses a temporary file to write the contents,
--- and then writes it to the specified file path
---@field sudo_write fun(tmpfile?: string, filepath?: string): nil


