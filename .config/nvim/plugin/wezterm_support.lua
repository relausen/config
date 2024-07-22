local nvim_user_var_format = "\027]1337;SetUserVar=IS_NVIM=%s\b"

local function formatted_user_var(value)
  local b64_encoded_value = value and vim.base64.encode(value) or ""
  return string.format(nvim_user_var_format, b64_encoded_value)
end

local function set_nvim_user_var(value)
  io.stdout:write(formatted_user_var(value))
end

set_nvim_user_var("true")

vim.api.nvim_create_autocmd("VimResume", {
  callback = function()
    set_nvim_user_var("true")
  end,
})

vim.api.nvim_create_autocmd({ "VimSuspend", "VimLeavePre" }, {
  callback = function()
    set_nvim_user_var(nil)
  end,
})

vim.api.nvim_create_user_command("ResetWezTermUserVar", function()
  set_nvim_user_var("true")
end, {})
