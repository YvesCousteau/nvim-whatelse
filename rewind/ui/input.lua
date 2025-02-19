local api = vim.api
local rewind = require("rewind")
local M = {}

local function setup(default, callback)
	rewind.keymaps.input.setup(default, callback)

	api.nvim_buf_set_option(rewind.state.buf.input, "modifiable", true)
	api.nvim_buf_set_lines(rewind.state.buf.input, 0, -1, false, { default or "" })
	local line_length = #default
	api.nvim_win_set_cursor(rewind.state.win.floating.input, { 1, line_length })
	vim.cmd("startinsert!")
end

local function create_window()
	local pos = rewind.config.options.ui.position.input
	rewind.ui.create_window(rewind.state.buf, "input", rewind.state.win.floating, pos, true, true)
end

function M.open_window(title, callback, default)
	rewind.config.options.ui.position.input.title = title
	create_window()
	setup(default or "", callback)
end

return M
