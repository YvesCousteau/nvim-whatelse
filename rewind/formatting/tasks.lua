local api = vim.api
local rewind = require("rewind")
local M = {}

function M.setup(content)
	local todo = rewind.config.options.formatting.tasks.state.todo.icon
	local doing = rewind.config.options.formatting.tasks.state.doing.icon
	local done = rewind.config.options.formatting.tasks.state.done.icon
	local icon = ""
	if "TODO" == content.state then
		icon = todo
	elseif "DOING" == content.state then
		icon = doing
	elseif "DONE" == content.state then
		icon = done
	end
	return icon .. content.title
end

function M.reverse(content)
	local todo = rewind.config.options.formatting.tasks.state.todo.icon
	local doing = rewind.config.options.formatting.tasks.state.doing.icon
	local done = rewind.config.options.formatting.tasks.state.done.icon
	content = content:gsub("^" .. vim.pesc(todo), "")
	content = content:gsub("^" .. vim.pesc(doing), "")
	content = content:gsub("^" .. vim.pesc(done), "")
	content = content:match("^%s*(.-)%s*$")
	return content
end

return M
