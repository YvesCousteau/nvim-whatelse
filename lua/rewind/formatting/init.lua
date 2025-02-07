local api = vim.api
local rewind = require("rewind")
local M = {}

M.boards = rewind.lazy_load("rewind.formatting.boards")
M.board = rewind.lazy_load("rewind.formatting.board")
M.lists = rewind.lazy_load("rewind.formatting.lists")
M.list = rewind.lazy_load("rewind.formatting.list")
M.tasks = rewind.lazy_load("rewind.formatting.tasks")
M.task = rewind.lazy_load("rewind.formatting.task")

function M.setup(content, content_type)
	if content then
		return M[content_type].setup(content)
	else
		return content
	end
end

function M.reverse(content, content_type)
	if content then
		return M[content_type].reverse(content)
	else
		return content
	end
end

return M
