local font_size = 13

local wezterm = require("wezterm")
local key_bindings = require("key-bindings")
local hyperlinks = require("hyperlinks")

local mux = wezterm.mux
local config = wezterm.config_builder()

config.audible_bell = "Disabled"
config.color_scheme = "Tokyo Night"
config.cursor_thickness = 2
config.default_cursor_style = "SteadyBar"
config.default_gui_startup_args = { "connect", "unix" }
-- config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })
config.font_size = font_size
config.hyperlink_rules = hyperlinks.hyperlink_rules
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5,
}
config.keys = key_bindings.keys
config.key_tables = key_bindings.key_tables
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.max_fps = 120
config.tab_bar_at_bottom = true
config.unix_domains = {
  {
    name = "unix",
  },
}
config.window_decorations = "RESIZE"
config.window_frame = {
  font_size = font_size,
}
config.window_padding = {
  left = "0.5cell",
  right = "0.5cell",
  top = "0.5cell",
  bottom = "0.5cell",
}

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local home_dir = os.getenv("HOME")
  local pane = tab.active_pane

  local title = tab_title(tab)

  local current_working_dir = pane.current_working_dir or wezterm.url.parse("file://" .. home_dir)
  local current_dir = current_working_dir.file_path:sub(1, -2):gsub(home_dir, "~")
  return {
    {
      Text = current_dir .. " - " .. title .. " ",
    },
  }
end)

wezterm.on("update-right-status", function(window, pane)
  if not pane then
    return
  end
  local info = pane:get_foreground_process_info()
  if info then
    window:set_right_status(table.concat(info.argv, " "))
  else
    window:set_right_status("")
  end
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while number_value > 0 do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

-- Copied from WezTerm docs: https://wezfurlong.org/wezterm/config/lua/window/set_config_overrides.html
wezterm.on("toggle-ligature", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.harfbuzz_features then
    -- If we haven't overridden it yet, then override with ligatures disabled
    overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
  else
    -- else we did already, and we should disable out override now
    overrides.harfbuzz_features = nil
  end
  window:set_config_overrides(overrides)
end)

return config
