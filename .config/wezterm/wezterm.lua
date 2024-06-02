local font_size <const> = 13

local wezterm = require 'wezterm'
local key_bindings = require 'key-bindings'
local hyperlinks = require('hyperlinks')

local mux = wezterm.mux
local config = wezterm.config_builder()

config.audible_bell = "Disabled"
config.color_scheme = 'Tokyo Night'
config.cursor_thickness = 2
config.default_cursor_style = 'SteadyBar'
config.font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Medium' })
config.font_size = font_size
config.hyperlink_rules = hyperlinks.hyperlink_rules
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5
}
config.keys = key_bindings.keys
config.key_tables = key_bindings.key_tables
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.tab_bar_at_bottom = false
config.window_decorations = 'RESIZE'
config.window_frame = {
  font_size = font_size
}
config.window_padding = {
  left = "0.5cell",
  right = "0.5cell",
  top = "0.5cell",
  bottom = "0.5cell",
}

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return config
