local api = vim.api
local rewind = require("rewind")
local M = {}

function M.add()
	rewind.ui.input.open_window("|> Add List ", function(input)
		rewind.controller.add("lists", input)
	end)
end

function M.update()
	local current_list = rewind.state.get_current("list")
	rewind.ui.input.open_window("|> Update List ", function(input)
		rewind.controller.set("list", input)
	end, current_list)
end

function M.delete()
	rewind.controller.delete("list")
end

function M.back()
	api.nvim_set_current_win(rewind.state.win.static.boards)
end

function M.next()
	if not rewind.util.is_buffer_empty(rewind.state.buf.tasks) then
		api.nvim_set_current_win(rewind.state.win.static.tasks)
	end
end

function M.setup()
	rewind.util.set_keymap(rewind.state.buf.lists, "n", rewind.config.options.keymaps.select, function()
		local current_tasks = rewind.state.get_current("tasks")
		if current_tasks and #current_tasks > 0 then
			M.next()
		else
			rewind.keymaps.tasks.add()
		end
	end)

	rewind.util.set_keymap(rewind.state.buf.lists, "n", rewind.config.options.keymaps.add, function()
		M.add()
	end)

	rewind.util.set_keymap(rewind.state.buf.lists, "n", rewind.config.options.keymaps.update, function()
		M.update()
	end)

	rewind.util.set_keymap(rewind.state.buf.lists, "n", rewind.config.options.keymaps.delete, function()
		M.delete()
	end)

	rewind.util.set_keymap(rewind.state.buf.lists, "n", rewind.config.options.keymaps.back, function()
		M.back()
	end)
end

return M
