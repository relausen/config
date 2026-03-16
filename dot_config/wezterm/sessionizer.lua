local M = {}

local wezterm = require("wezterm")
local act = wezterm.action

local utils = require("utils")

local brew_bin_dir = "/opt/homebrew/bin"
local fd = brew_bin_dir .. "/fd"
local git = brew_bin_dir .. "/git"

local home = wezterm.home_dir
local dev_path = home .. "/development"
local config_path = home .. "/.config"

local search_folders = {
  dev_path,
  config_path,
}

local function normalized_path(path)
  return path:gsub(home, "~")
end

local function run_fd(extra_params)
  local default_params = { "--hidden", "--no-ignore", "--type=d", "--max-depth=1", "--prune", "." }
  local params = utils.merge_tables(default_params, extra_params)
  return utils.run_program(fd, params)
end

local function git_worktrees(bare_repo)
  return utils.run_program(git, { "--git-dir", bare_repo, "worktree", "list" })
end

local function add_git_worktrees(projects, bare_repo)
  local success, worktrees, stderr = git_worktrees(bare_repo)
  if not success then
    return false, stderr
  end
  for wt_line in worktrees:gmatch("([^\n]*)\n?") do
    if not wt_line:find(".bare") then
      local wt_project = wt_line:match("(%g-)%s+.*")
      local wt_label = normalized_path(wt_project)
      local proj, wt = wt_project:match(home .. "/%g-/(.-)/(.*)")
      local wt_id = proj .. " - " .. wt
      table.insert(projects, { label = wt_label, id = wt_id })
    end
  end
  return true, ""
end

M.start = function(window, pane)
  local projects = {}

  local success, stdout, stderr = run_fd(search_folders)

  if not success then
    wezterm.log_error("Failed to run fd: " .. stderr)
    return
  end

  for _, dir in ipairs(search_folders) do
    local label = normalized_path(dir)
    local id = normalized_path(dir):gsub("~/", "")
    table.insert(projects, { label = label, id = id })
  end

  for line in stdout:gmatch("([^\n]*)\n?") do
    local project = line
    local label = normalized_path(project)
    local id = project:match(".*/(.+)/")
    table.insert(projects, { label = tostring(label), id = tostring(id) })
    if utils.isdir(project .. ".bare") then
      local success, err = add_git_worktrees(projects, project .. ".bare")
      if not success then
        wezterm.log_error("Failed to get Git worktrees: " .. err)
      end
    end
  end

  table.sort(projects, function(lhs, rhs)
    return lhs.label < rhs.label
  end)

  window:perform_action(
    act.InputSelector({
      action = wezterm.action_callback(function(win, _, id, label)
        if not id and not label then
          wezterm.log_info("Cancelled")
        else
          wezterm.log_info("Selected " .. label)
          win:perform_action(act.SwitchToWorkspace({ name = id, spawn = { cwd = label:gsub("~", home) } }), pane)
        end
      end),
      fuzzy = true,
      title = "Select project",
      choices = projects,
    }),
    pane
  )
end

return M
