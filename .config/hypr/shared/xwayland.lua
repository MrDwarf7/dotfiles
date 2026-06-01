--###############
--## XWAYLAND ###
--###############

hl.config({
  xwayland = {
    enabled = true,
    use_nearest_neighbor = true,
    force_zero_scaling = true,
    create_abstract_socket = false,
  },
})
