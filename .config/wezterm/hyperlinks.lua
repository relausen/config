local wezterm = require 'wezterm'

local M = {}

local hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

M.hyperlink_rules = hyperlink_rules

return M
