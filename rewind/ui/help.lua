local api = vim.api
local rewind = require("rewind")
local M = {}

local function setup()
	rewind.autocmd.help.setup()
	rewind.keymaps.boards.setup()
end

local function create_window()
	local pos = nil
	local is_focused = nil
	if rewind.ui.is_window_open(rewind.state.win.floating.help) then
		rewind.ui.close_window(rewind.state.win.floating.help)
	end
	if rewind.state.help.is_expanded then
		pos = rewind.config.options.ui.position.help_expand
		is_focused = true
	else
		pos = rewind.config.options.ui.position.help_collapse
		is_focused = false
	end
	rewind.ui.create_window(rewind.state.buf, "help", rewind.state.win.floating, pos, is_focused, false)
end

function M.open_window()
	create_window()
	setup()
end

return M
