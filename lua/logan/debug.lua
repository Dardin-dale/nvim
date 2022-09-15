
local dap_status_ok, dap = pcall(require, "nvim-dap")
if not dap_status_ok then
  return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

local dap_text_status_ok, dap_text = pcall(require, "nvim-dap-virtual-text")
if not dap_text_status_ok then
  return
end

dap.setup()
dapui.setup()
dap_text.setup()



