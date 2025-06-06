local dap_status_ok, dap = pcall(require, "nvim-dap")
if not dap_status_ok then
	return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
	return
end

local dap_text_status_ok, dap_text = pcall(require, "nvim-dap-virtual-text")
if not dap_text_status_ok then
	return
end

dap.setup()
dapui.setup()
dap_text.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
