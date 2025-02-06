local api = vim.api
local rewind = require("rewind")
local M = {}

function M.create_lists_window(buf, win, config)
	rewind.ui.util.create_window(
		buf,
		"lists",
		win,
		" 󰉺 LISTS ",
		math.floor((vim.o.columns * config.width_percentage) / 4),
		math.floor((vim.o.lines * config.height_percentage) / 2),
		math.floor((vim.o.lines * config.width_percentage) * 1.48),
		math.floor((vim.o.lines * config.height_percentage) / 2),
		false,
		false
	)
end

return M
