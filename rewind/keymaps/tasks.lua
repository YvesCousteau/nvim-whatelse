local api = vim.api
local rewind = require("rewind")
local M = {}

function M.add()
	rewind.ui.input.open_window("|> Add Task ", function(input)
		rewind.controller.add("tasks", input)
	end)
end

function M.update()
	local current_task = rewind.state.get_current("task")
	rewind.ui.input.open_window("|> Update Task ", function(input)
		rewind.controller.set("task", input)
	end, current_task)
end

function M.delete()
	rewind.controller.delete("task")
end

function M.back()
	api.nvim_set_current_win(rewind.state.win.static.lists)
end

function M.setup()
	rewind.util.set_keymap(rewind.state.buf.tasks, "n", rewind.config.options.keymaps.select, function()
		M.update()
	end)

	rewind.util.set_keymap(rewind.state.buf.tasks, "n", rewind.config.options.keymaps.update, function()
		M.update()
	end)

	rewind.util.set_keymap(rewind.state.buf.tasks, "n", rewind.config.options.keymaps.add, function()
		M.add()
	end)

	rewind.util.set_keymap(rewind.state.buf.tasks, "n", rewind.config.options.keymaps.delete, function()
		M.delete()
	end)

	rewind.util.set_keymap(rewind.state.buf.tasks, "n", rewind.config.options.keymaps.back, function()
		M.back()
	end)
end

return M
