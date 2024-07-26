local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local M = {}

local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(key)
  return {
    key = key,
    mods = "CTRL",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        win:perform_action({
          SendKey = { key = key, mods = "CTRL" },
        }, pane)
      else
        win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
      end
    end),
  }
end

local nav_keys = {
  -- move between split panes
  split_nav("h"),
  split_nav("j"),
  split_nav("k"),
  split_nav("l"),
  -- Attach to muxer
  {
    key = "a",
    mods = "LEADER",
    action = act.AttachDomain("unix"),
  },
  -- Detach from muxer
  {
    key = "d",
    mods = "LEADER",
    action = act.DetachDomain({ DomainName = "unix" }),
  },
  {
    key = "a",
    mods = "LEADER|CTRL",
    action = act.SendKey({ key = "a", mods = "CTRL" }),
  },
  {
    key = "h",
    mods = "LEADER|CTRL",
    action = act.SendKey({ key = "h", mods = "CTRL" }),
  },
  {
    key = "j",
    mods = "LEADER|CTRL",
    action = act.SendKey({ key = "j", mods = "CTRL" }),
  },
  {
    key = "k",
    mods = "LEADER|CTRL",
    action = act.SendKey({ key = "k", mods = "CTRL" }),
  },
  {
    key = "l",
    mods = "LEADER|CTRL",
    action = act.SendKey({ key = "l", mods = "CTRL" }),
  },
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
  },
  {
    key = "s",
    mods = "LEADER",
    action = act.ShowLauncherArgs({ flags = "WORKSPACES|TABS" }),
  },
  {
    key = "t",
    mods = "LEADER",
    action = act.ShowTabNavigator,
  },
  {
    key = "u",
    mods = "SHIFT|CTRL",
    action = wezterm.action.CharSelect({
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    }),
  },
  {
    key = "|",
    mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "m",
    mods = "LEADER",
    action = act.TogglePaneZoomState,
  },
  {
    key = "Enter",
    mods = "SUPER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain", cwd = "~" }),
  },
  {
    key = "Enter",
    mods = "SUPER|SHIFT",
    action = act.SplitPane({ direction = "Right", size = { Percent = 33 } }),
  },
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  {
    key = "w",
    mods = "LEADER",
    action = act.ShowTabNavigator,
  },
  {
    key = "$",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Enter new name for session",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          mux.rename_workspace(window:mux_window():get_workspace(), line)
        end
      end),
    }),
  },
  -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  {
    key = "LeftArrow",
    mods = "OPT",
    action = act.SendKey({
      key = "b",
      mods = "ALT",
    }),
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = act.SendKey({ key = "f", mods = "ALT" }),
  },
}

M.key_tables = {
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
}

M.keys = nav_keys

return M
