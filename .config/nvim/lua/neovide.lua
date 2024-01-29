vim.o.guifont = "FiraCode Nerd Font:h14"
vim.opt.linespace = 0 -- can also be a negative value
vim.g.neovide_scale_factor = 0.8

vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0

vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 15

vim.g.neovide_confirm_quit = false -- defaults true
vim.g.neovide_remember_window_size = true -- can be overwritten by passing --size on the CLI

-- Cursor settings:
vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_cursor_trail_size = 0.4

vim.g.neovide_cursor_antialiasing = false -- Disabling may fix some cursor visual issues.

-- Cursor patricles
-- Disabled
-- vim.g.neovide_cursor_vfx_mode = ""
--
-- Other options:
-- "railgun"
-- "torpedo"
-- "pixiedust"
-- "sonicboom"
-- "ripple"
-- "wireframe"

-- Particle settings
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_density = 7.0
vim.g.neovide_cursor_vfx_particle_speed = 10.0
-- vim.g.neovide_cursor_vfx_particle_phase = 1.5 -- Only for the railfun mode
-- vim.g.neovide_cursor_vfx_particle_curl = 1.0 -- Only for the railfun mode
