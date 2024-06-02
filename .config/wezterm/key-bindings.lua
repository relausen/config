local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local function is_vim(pane)
  local process_info = pane:get_foreground_process_info()
  local process_name = process_info and process_info.name

  return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
  -- reverse lookup
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "META" or "CTRL",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local nav_keys = {
  -- move between split panes
  split_nav("move", "h"),
  split_nav("move", "j"),
  split_nav("move", "k"),
  split_nav("move", "l"),
  -- resize panes
  split_nav("resize", "h"),
  split_nav("resize", "j"),
  split_nav("resize", "k"),
  split_nav("resize", "l"),
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = act.SendKey { key = 'a', mods = 'CTRL' },
  },
  {
    key = 'h',
    mods = 'LEADER|CTRL',
    action = act.SendKey { key = 'h', mods = 'CTRL' },
  },
  {
    key = 'j',
    mods = 'LEADER|CTRL',
    action = act.SendKey { key = 'j', mods = 'CTRL' },
  },
  {
    key = 'k',
    mods = 'LEADER|CTRL',
    action = act.SendKey { key = 'k', mods = 'CTRL' },
  },
  {
    key = 'l',
    mods = 'LEADER|CTRL',
    action = act.SendKey { key = 'l', mods = 'CTRL' },
  },
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable { name = "resize_pane", one_shot = false }
  },
  {
    key = 't',
    mods = 'LEADER',
    action = act.ShowTabNavigator,
  },
  {
    key = '|',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'm',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },
  {
    key = 'Enter',
    mods = 'SUPER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  }
}

M.key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
    { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
    { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
    { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
}

M.keys = nav_keys

return M
