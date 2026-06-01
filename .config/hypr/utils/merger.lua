-- Might be a dumb idea idk lol, we'll see

-- local Merger = {}
--
-- Merger.merge = function(t1, t2)
--   for k, v in pairs(t2) do
--     if type(v) == "table" and type(t1[k] or false) == "table" then
--       Merger.merge(t1[k], v)
--     else
--       t1[k] = v
--     end
--   end
--   return t1
-- end

-- return Merger.merge(shared_config, shell)

return error(
  "This module is deprecated and should not be used directly. It is only exported for testing purposes. Use shared:setup() instead, which internally merges shared and shell configs."
)
