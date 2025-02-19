local api = vim.api
local rewind = require("rewind")
local M = {}

function M.add()
	rewind.ui.input.open_window("|> Add Board ", function(input)
		rewind.controller.add("boards", input)
	end)
end

function M.update()
	local current_board = rewind.state.get_current("board")
	rewind.ui.input.open_window("|> Update Board ", function(input)
		rewind.controller.set("board", input)
	end, current_board)
end

function M.delete()
	rewind.controller.delete("board")
end

function M.back()
	rewind.ui.close_window(rewind.state.win.static.boards)
end

function M.next()
	if not rewind.util.is_buffer_empty(rewind.state.buf.lists) then
		api.nvim_set_current_win(rewind.state.win.static.lists)
	end
end

function M.setup()
	rewind.util.set_keymap(rewind.state.buf.boards, "n", rewind.config.options.keymaps.select, function()
		local current_lists = rewind.state.get_current("lists")
		if current_lists and #current_lists > 0 then
			M.next()
		else
			rewind.keymaps.lists.add()
		end
	end)

	rewind.util.set_keymap(rewind.state.buf.boards, "n", rewind.config.options.keymaps.add, function()
		M.add()
	end)

	rewind.util.set_keymap(rewind.state.buf.boards, "n", rewind.config.options.keymaps.update, function()
		M.update()
	end)

	rewind.util.set_keymap(rewind.state.buf.boards, "n", rewind.config.options.keymaps.delete, function()
		M.delete()
	end)

	rewind.util.set_keymap(rewind.state.buf.boards, "n", rewind.config.options.keymaps.back, function()
		M.back()
	end)
end

return M
