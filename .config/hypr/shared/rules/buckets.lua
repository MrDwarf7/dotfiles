--- Bucket behaviors. Defines each behavior ONCE, keyed by bucket tag name.
--- App files opt in via the exported bucket() helper.
---
--- Buckets are the single source of truth for shared window behavior.
--- Each stanza below emits one effect rule matched on the bucket tag.
--- App membership lives in per-app files (they call bucket()).

---@module 'types'

--- Takes a table and a key, and returns the value associated with that key in the table.
--- Is used as the `__index` metamethod for the given table, allowing for case insensitive lookup of keys.
---
---@generic T:table Represents a table with string keys and any values.
---@generic F:fun():any Represents a function that returns any value.
---
---@param tbl T The table to be used for case insensitive lookup.
---@param key string The key to be looked up in the table.
---@return T[key] | F | nil The value associated with the key in the table, or nil if the key is not found.
local case_insensitive_index = function(tbl, key)
  local kt = { key = key, ukey = nil, lkey = nil }
  if type(kt.key) == "string" then
    kt.ukey = string.upper(kt.key)
    kt.lkey = string.lower(kt.key)
  end

  ------- collapse this stuff into a metatable fn call

  -- -- we check the raw get
  if rawget(tbl, kt.key) ~= nil then
    return kt.key
  end

  -- raw key bad, try upper
  if rawget(tbl, kt.ukey) ~= nil then
    return kt.ukey
  end
  -- raw and upper bad, try lower
  if rawget(tbl, kt.lkey) ~= nil then
    return kt.lkey
  end

  if rawget(tbl, kt.key) == nil and rawget(tbl, kt.ukey) == nil and rawget(tbl, kt.lkey) == nil then
    return nil
  end
  return nil
end

--- Mini fn to be used as the __index metamethod for a table, allowing for case insensitive lookup of keys.
---
---@generic T:table
---@generic key: string
---
---@param tbl table The table to be used for case insensitive lookup.
---@param key string The key to be looked up in the table.
---@return T[key] # The value associated with the key in the table, or nil if the key is not found.
local index_fn = function(tbl, key)
  return rawget(tbl, case_insensitive_index(tbl, key))
end

---@enum Bucket
local bkt_types = {
  BROWSERS = "browsers",
  EMAIL = "email",
  GUI_EDITORS = "gui_editors",
  GAMING = "gaming",
  NOTES = "notes",
  TICKETS = "tickets",
  PRIVATE_COMMS = "private_comms",
  MUSIC = "music",
  -----------
  TERMINALS = "terminals",
  FILE_MANAGERS = "file_managers",
  FLOAT_INDICATORS = "float_indicators",
}

setmetatable(bkt_types, { __index = index_fn })

---@class BucketToWorkspaceMapping
local bkt_to_ws = {
  BROWSERS = "1 silent",
  -- 2
  EMAIL = "3 silent",
  GUI_EDITORS = "3 silent",
  GAMING = "4 silent",
  NOTES = "5 silent",
  TICKETS = "5 silent",
  PRIVATE_COMMS = "6 silent",
  -------- 2nd mon
  -- 7
  MUSIC = "8 silent",
  -- 9
}

--- Attempts to get the workspace associated with a given bucket name (case-insensitive).
---@param bkt_name any
---@return string|nil
function bkt_to_ws:try_get(bkt_name)
  local bkt_key = case_insensitive_index(bkt_types, bkt_name) or error("Invalid bucket name: " .. tostring(bkt_name))
  return self[bkt_key] or self[bkt_name] or nil
end

setmetatable(bkt_to_ws, { __index = index_fn })

local OPACITY_OVERRIDE = "1.00 override 1.00 override"

--- Email clients (thunderbird, etc). WS3.
hl.window_rule({
  name = "bucket-" .. bkt_types.EMAIL,
  match = { tag = bkt_types.EMAIL },
  workspace = bkt_to_ws.EMAIL,
  opacity = OPACITY_OVERRIDE,
})

--- Private comms (telegram, signal). WS6.
hl.window_rule({
  name = "bucket-" .. bkt_types.PRIVATE_COMMS,
  match = { tag = bkt_types.PRIVATE_COMMS },
  workspace = bkt_to_ws.PRIVATE_COMMS,
  no_initial_focus = true,
  -- size = "(monitor_w*0.40) (monitor_h*0.65)",
})

--- Music apps (spotify, youtube-music). WS8 + maximize.
hl.window_rule({
  name = "bucket-" .. bkt_types.MUSIC,
  match = { tag = bkt_types.MUSIC },
  workspace = bkt_to_ws.MUSIC,
  maximize = true,
  -- opacity = OPACITY_OVERRIDE,
})

--- GUI editors (code, zed, jetbrains). WS3 + opacity + no initial focus + persistent size.
hl.window_rule({
  name = "bucket-" .. bkt_types.GUI_EDITORS,
  match = { tag = bkt_types.GUI_EDITORS },
  workspace = bkt_to_ws.GUI_EDITORS,
  no_initial_focus = true,
  opacity = OPACITY_OVERRIDE,
  persistent_size = true,
})

--- Browsers (vivaldi, zen, chromium). WS1 + opacity + persistent size.
hl.window_rule({
  name = "bucket-" .. bkt_types.BROWSERS,
  match = { tag = bkt_types.BROWSERS },
  workspace = bkt_to_ws.BROWSERS,
  opacity = OPACITY_OVERRIDE,
  persistent_size = true,
})

--- Notes (obsidian, todoist). WS5 + opacity + no initial focus + persistent size.
hl.window_rule({
  name = "bucket-" .. bkt_types.NOTES,
  match = { tag = bkt_types.NOTES },
  workspace = bkt_to_ws.NOTES,
  no_initial_focus = true,
  opacity = OPACITY_OVERRIDE,
  persistent_size = true,
})

--- Tickets / work tracking (affine, linear). WS5.
hl.window_rule({
  name = "bucket-" .. bkt_types.TICKETS,
  match = { tag = bkt_types.TICKETS },
  workspace = bkt_to_ws.TICKETS,
  -- center = true,
  -- opacity = OPACITY_OVERRIDE,
})

--- Gaming (steam, lutris, faugus, heroic). WS4.
hl.window_rule({
  name = "bucket-" .. bkt_types.GAMING,
  match = { tag = bkt_types.GAMING },
  workspace = bkt_to_ws.GAMING,
  border_size = 0,
  no_blur = true,
  opacity = OPACITY_OVERRIDE,
})

--- Terminals (ghostty, wezterm, kitty). No workspace; borderless + persistent size.
hl.window_rule({
  name = "bucket-" .. bkt_types.TERMINALS,
  match = { tag = bkt_types.TERMINALS },
  border_size = 0,
  persistent_size = true,
  -- size = "(monitor_w*0.40) (monitor_h*0.65)",
})

--- File managers (thunar, nemo, dolphin). Float + monitor-relative size + opacity.
hl.window_rule({
  name = "bucket-" .. bkt_types.FILE_MANAGERS,
  match = { tag = bkt_types.FILE_MANAGERS },
  center = true,
  float = true,
  opacity = OPACITY_OVERRIDE,
  persistent_size = true,
  -- size = "(monitor_w*0.40) (monitor_h*0.65)",
})

--- Float indicators (screen share overlays). Float + pin.
hl.window_rule({
  name = "bucket-" .. bkt_types.FLOAT_INDICATORS,
  match = { tag = bkt_types.FLOAT_INDICATORS },
  float = true,
  pin = true,
})

--- Put a window into a bucket. Caller supplies the match (class/title/etc).
---@param match table
---@param bkt_name Bucket The bucket name (case-insensitive). Must match one of the defined buckets above.
---@return void
local assign_bucket = function(match, bkt_name)
  hl.window_rule({
    -- IMP: We CANNOT name these! This is because of (hyprlands static vs. dynamic) VS. how orderings are done!
    --Effects marked as Dynamic are reevaluated whenever the matching property of the window changes.
    --For instance, if a rule changes the border_color when a window is floating, the color reverts to default when it’s tiled again.
    -- -----
    -- Effects are processed top to bottom - the last match takes precedence:

    -- name = "tag-" .. bucket_name,
    match = match,
    tag = "+" .. bkt_name,
  })
end

---@class BucketModule
---@field types table<string, string> The bucket types (case-insensitive).
---@field bkt_to_ws table<string, string> The mapping of bucket types to workspaces (case-insensitive).
---@field assign_bucket fun(match: table, bkt_name: Bucket): void Assigns a window to a bucket based on the provided match and bucket name.
---@field get fun(self: BucketModule, bkt_name: Bucket): { bucket: Bucket, workspace: string } Gets the bucket and workspace for the provided bucket name (case-insensitive).
local M = {
  types = bkt_types,

  -- TODO: [types] : Re the 'match' param below -
  -- Currently HL.WindowRuleSpec is... mostly useless lol... So we'll want to create a type that
  -- 1) inherits from existing HL.WindowRuleSpec,
  -- 2) Create a new class/type that is
  -- HyprConfig.WindowRuleMatchSpec - and overwrite the existing 'match?' attr
  -- (cos it's mostly useless and doesn't properly represent the match block itself lol...)
  --

  bkt_to_ws = bkt_to_ws,
  assign_bucket = assign_bucket,
}

---@class BucketModule.get
---@field bucket Bucket The bucket name (case-insensitive). Must match one of the defined buckets above.
---@field workspace string|nil The workspace that bucket is assigned to (if any).

--- Provided a type of bucket name - will return you back a table
--- that contains:
--- `bucket` - which is the primary key,
--- `workspace` - which is the workspace that bucket is assigned to (if any).
---@param bkt_name Bucket The bucket name (case-insensitive lookup, returned as upper). Must match one of the defined buckets above.
---@return BucketModule.get
function M:get(bkt_name)
  bkt_name = self.types[bkt_name] or case_insensitive_index(self.types, bkt_name)
  local ws_value = self.bkt_to_ws:try_get(bkt_name) or self.bkt_to_ws[bkt_name] or nil

  return { bucket = bkt_name, workspace = ws_value }
end

setmetatable(M, {
  --- __index metamethod for the BucketModule table.
  --- @param _ any
  --- @param key any
  --- @return table
  __index = function(_, key)
    if M:get(key) then
      return M:get(key)
    end

    if M.types[key] then
      return M.types[key]
    elseif M.bkt_to_ws[key] then
      return M.bkt_to_ws[key]
    else
      error("Invalid bucket key: " .. tostring(key))
    end
  end,

  --- __call metamethod for the BucketModule table.
  ---@param _ any
  ---@param ... unknown
  ---@return nil
  __call = function(_, ...)
    return M.assign_bucket(...)
  end,
})

---@return BucketModule
return M
