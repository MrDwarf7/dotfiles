-- label.lua: label each terminal with the directory it is in
rex.on("terminal.pwd_changed", function(ctx, ev)
  local dir = ev.pwd:match("([^/]+)/?$")
  rex.session.set_block_label({
    block_id = ctx.block_id,
    label = dir,
  })
end)
