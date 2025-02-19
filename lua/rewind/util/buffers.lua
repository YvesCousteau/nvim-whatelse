local M = {}
local rewind = require("rewind")
local state = rewind.state

function M.reset()
	for _, key in pairs(state.list) do
		local buf = M.get(key)
		if buf and vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

function M.init(key)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, key)
	if not vim.api.nvim_buf_is_valid(buf) then
		print("Buffer " .. key .. " is not valid")
	end
end

function M.get(key)
	local buf = vim.fn.bufnr(key)
	if buf and vim.api.nvim_buf_is_valid(buf) then
		return buf
	end
end

function M.get_var(key)
	local buf = M.get(key)
	if buf then
		return vim.api.nvim_buf_get_var(buf, key)
	end
end

function M.get_line(key)
	local buf = M.get(key)
	local row, col = unpack(vim.api.nvim_buf_get_mark(buf, '"'))
	local lines = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)
	if #lines > 0 then
		return lines[1]
	else
		return nil
	end
end

function M.is_empty(key)
	local buf = M.get(key)
	if buf then
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		if #lines > 0 then
			return true
		end
	end
end

function M.set_var(key, buf, var)
	if buf and vim.api.nvim_buf_is_valid(buf) then
		vim.api.nvim_buf_set_var(buf, key, var)
	end
end

function M.set_content(key, content)
	local buf = M.get(key)
	vim.api.nvim_buf_set_option(buf, "modifiable", true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

return M
