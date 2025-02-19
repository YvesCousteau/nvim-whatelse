local M = {}
local rewind = require("rewind")
local state = rewind.state
local config = rewind.config
M.buf = rewind.lazy_load("rewind.util.buffers")
M.win = rewind.lazy_load("rewind.util.windows")
M.prompt = rewind.lazy_load("rewind.util.prompt")

function M.reset_namespace()
	for _, key in pairs(state.list) do
		M.buf.get(key)
		vim.api.nvim_buf_clear_namespace(buf, state.namespace, 0, -1)
	end
end

function M.set_highlight(buf)
	M.reset_namespace()
	local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
	api.nvim_buf_add_highlight(buf, state.namespace, "", current_line, 0, -1)
end

function M.get_focused_line()
	return vim.api.nvim_get_current_line()
end

function M.toggle_visiblity(key)
	if config.windows.custom[key].is_visible == "false" then
		config.windows.custom[key].is_visible = "true"
	else
		config.windows.custom[key].is_visible = "false"
	end
	return config.windows.custom[key].is_visible
end

function M.change_window_title(key, title)
	if title then
		config.windows.custom[key].title_opt = title
	end
end

function M.switch_window(key)
	local win = M.win.get(key)
	if win then
		vim.api.nvim_set_current_win(win)
	end
end

function M.get_prev_buf()
	return state.prev_buf
end

function M.set_prev_buf(key)
	state.prev_buf = key
end

local random = math.random
function M.uuid()
	local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
	return string.gsub(template, "[xy]", function(c)
		local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
		return string.format("%x", v)
	end)
end

return M
