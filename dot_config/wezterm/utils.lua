local M = {}

local wezterm = require("wezterm")

--- Merge numeric tables
---@param t1 table
---@param t2 table
---@return table
M.merge_tables = function(t1, t2)
  local result = {}
  for index, value in ipairs(t1) do
    result[index] = value
  end
  for index, value in ipairs(t2) do
    result[#t1 + index] = value
  end
  return result
end

-- Based on an this SO answer: https://stackoverflow.com/a/40195356
M.exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

--- Check if a directory exists in this path
M.isdir = function(path)
  -- "/" works on both Unix and Windows
  return M.exists(path .. "/")
end

M.run_program = function(program, params)
  local cmd = M.merge_tables({ program }, params)
  return wezterm.run_child_process(cmd)
end

return M
