local api = vim.api
local rewind = require("rewind")
local M = {}

function M.setup()
	rewind.autocmd.win_close(rewind.state.buf.tasks, function()
		rewind.ui.close_all_window()
	end)

	rewind.autocmd.cursor_move(rewind.state.buf.tasks, function()
		rewind.util.update_highlight(rewind.state.buf.tasks, rewind.state.namespace.highlight)
		rewind.state.set_current("task", rewind.util.get_current_line("task"))
	end)
end

return M
