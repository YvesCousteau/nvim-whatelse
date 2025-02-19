local api = vim.api
local rewind = require("rewind")
local M = {}

function M.setup()
	rewind.autocmd.win_close(rewind.state.buf.lists, function()
		rewind.ui.close_all_window()
	end)

	rewind.autocmd.cursor_move(rewind.state.buf.lists, function()
		rewind.util.update_highlight(rewind.state.buf.lists, rewind.state.namespace.highlight)
		rewind.state.set_current("list", rewind.util.get_current_line("list"))
		rewind.util.update_content("tasks")
	end)
end

return M
