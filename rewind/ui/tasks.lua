local api = vim.api
local rewind = require("rewind")
local M = {}

function M.setup()
	rewind.autocmd.tasks.setup()
	rewind.keymaps.tasks.setup()

	rewind.util.clear_highlights(rewind.state.buf, rewind.state.namespace.highlight)
	rewind.util.update_highlight(rewind.state.buf.tasks, rewind.state.namespace.highlight)
end

function M.create_window(buf, win, config)
	local pos = rewind.config.options.ui.position.tasks
	rewind.ui.create_window(rewind.state.buf, "tasks", rewind.state.win.static, pos, false, false)
end

return M
