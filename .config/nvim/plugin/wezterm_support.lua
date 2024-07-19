local user_var_format = "\027]1337;SetUserVar=IS_NVIM=%s\007"

local function formatted_user_var(value)
  local b64_encoded_value = value and vim.base64.encode(value) or ""
  return string.format(user_var_format, b64_encoded_value)
end

local function set_user_var(value)
  io.stdout:write(formatted_user_var(value))
end

set_user_var("true")

vim.api.nvim_create_autocmd("VimResume", {
  callback = function()
    set_user_var("true")
  end,
})

vim.api.nvim_create_autocmd({ "VimSuspend", "VimLeavePre" }, {
  callback = function()
    set_user_var(nil)
  end,
})
