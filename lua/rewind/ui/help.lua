local M = {}
local rewind = require("rewind")
local ui = rewind.ui
local util = rewind.util

function M.toggle_window(key)
	local is_visible = util.toggle_visiblity(key)
	if is_visible == "false" then
		M.close_window(key)
	else
		M.open_window(key)
	end
end

function M.open_window(key)
	ui.util.init(key)
end

function M.close_window(key)
	util.win.close(key)
end

return M
