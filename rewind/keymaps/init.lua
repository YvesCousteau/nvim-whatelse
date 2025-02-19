local api = vim.api
local rewind = require("rewind")
local M = {}

M.boards = rewind.lazy_load("rewind.keymaps.boards")
M.lists = rewind.lazy_load("rewind.keymaps.lists")
M.tasks = rewind.lazy_load("rewind.keymaps.tasks")
M.help = rewind.lazy_load("rewind.keymaps.help")
M.input = rewind.lazy_load("rewind.keymaps.input")

local function quit(buf, win, type)
	rewind.util.set_keymap(buf[type], "n", rewind.config.options.keymaps.quit, function()
		rewind.ui.close_window(win[type])
	end)
end

local function help(buf, type)
	rewind.util.set_keymap(buf[type], "n", rewind.config.options.keymaps.help, function()
		rewind.state.help.type = type
		rewind.ui.close_window(rewind.state.win.floating.help)
	end)
end

function M.setup(buf, win, type)
	quit(buf, win, type)
	help(buf, type)
end

return M
