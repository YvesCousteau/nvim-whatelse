local api = vim.api
local rewind = require("rewind")
local M = {}

M.boards = rewind.lazy_load("rewind.autocmd.boards")
M.lists = rewind.lazy_load("rewind.autocmd.lists")
M.tasks = rewind.lazy_load("rewind.autocmd.tasks")
M.help = rewind.lazy_load("rewind.autocmd.help")

function M.setup()
	M.win_enter()
end

function M.win_close(buf, callback)
	api.nvim_clear_autocmds({
		event = "WinClosed",
		buffer = buf,
	})
	api.nvim_create_autocmd("WinClosed", {
		buffer = buf,
		callback = callback,
	})
end

function M.win_enter()
	api.nvim_create_autocmd("WinEnter", {
		callback = function()
			local current_win = api.nvim_get_current_win()
			if current_win == rewind.state.win.static.boards then
				rewind.ui.boards.setup()
			elseif current_win == rewind.state.win.static.lists then
				rewind.ui.lists.setup()
			elseif current_win == rewind.state.win.static.tasks then
				rewind.ui.tasks.setup()
			end
		end,
	})
end

function M.cursor_move(buf, callback)
	api.nvim_create_autocmd("CursorMoved", {
		buffer = buf,
		callback = callback,
	})
end

return M
