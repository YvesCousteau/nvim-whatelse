local M = {}
local rewind = require("rewind")
local state = rewind.state
local util = rewind.util
local ui = rewind.ui

function M.get()
	return state.prompt
end

function M.set(key, callback)
	local buf = util.buf.get(key)
	if vim.api.nvim_buf_is_valid(buf) then
		ui.prompt.close_window(key)
	end
	if key and callback and state.prompt then
		state.prompt = {
			key = key,
			callback = callback,
		}
	end
end

return M
