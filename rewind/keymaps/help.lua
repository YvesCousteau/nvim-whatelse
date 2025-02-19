local api = vim.api
local rewind = require("rewind")
local M = {}

function M.setup()
	rewind.util.set_keymap(rewind.state.buf.help, "n", rewind.config.options.keymaps.back, function()
		rewind.ui.close_window(rewind.state.win.floating.help)
	end)
end

return M
