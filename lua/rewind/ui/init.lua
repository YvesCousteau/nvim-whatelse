local M = {}
local rewind = require("rewind")
local config = rewind.config
local util = rewind.util
local autocmd = rewind.autocmd
local keymap = rewind.keymap
M.util = rewind.lazy_load("rewind.ui.util")
M.prompt = rewind.lazy_load("rewind.ui.prompt")
M.help = rewind.lazy_load("rewind.ui.help")

function create_window(key)
	util.buf.init(key)
	util.win.init(key)
end

function M.setup()
	util.buf.reset()
	util.win.reset()

	for key, _ in pairs(config.windows.custom) do
		create_window(key)
	end
	for key, _ in pairs(config.windows.custom) do
		autocmd.setup(key)
		keymap.setup(key)
	end
end

return M
