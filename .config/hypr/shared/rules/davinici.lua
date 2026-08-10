hl.window_rule({
  name = "tag-davinici-panels",
  match = { class = "^(Davinci Control Panels Setup)$" },
  tag = "+daviniciPanels",
})
hl.window_rule({
  name = "effect-davinici-panels",
  match = { tag = "daviniciPanels" },
  center = true,
  float = true,
  opacity = "1.0 override 1.0 override",
  size = "1280 720",
})
