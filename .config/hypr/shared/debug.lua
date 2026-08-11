--############
--## DEBUG ###
--############

hl.config({
  ---@type HL.ConfigOpt.Debug
  debug = {
    -- full_cm_proto = true

    disable_logs = false,
    -- vfr = false                                           # If we make this true, I seem to get blips/flickering
    -- PR - #13860
    -- adds invalidate_fp16 to disable fp16 buffer invalidation. Fixes glitches on some systems but reduces performance.
    -- invalidate_fp16 = false
  },
})
