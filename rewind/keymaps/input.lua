local api = vim.api
local rewind = require("rewind")
local M = {}

function M.setup(default, callback)
	rewind.util.set_keymap(rewind.state.buf.input, "i", rewind.config.options.keymaps.select, function()
		local input = api.nvim_buf_get_lines(rewind.state.buf.input, 0, -1, false)[1]
		if
			rewind.state.win.floating.input
			and rewind.state.win.floating.input
			and api.nvim_win_is_valid(rewind.state.win.floating.input)
		then
			rewind.ui.close_window(rewind.state.win.floating.input)
			vim.cmd("stopinsert")
			vim.schedule(function()
				callback(input)
			end)
		end
	end)

	rewind.util.set_keymap(rewind.state.buf.input, "i", rewind.config.options.keymaps.back, function()
		rewind.ui.close_window(rewind.state.win.floating.input)
		vim.cmd("stopinsert")
	end)
end

return M
