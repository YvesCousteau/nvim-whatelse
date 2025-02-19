local M = {}
local rewind = require("rewind")
local util = rewind.util
local boards = rewind.lazy_load("rewind.command.boards")
local lists = rewind.lazy_load("rewind.command.lists")
local tasks = rewind.lazy_load("rewind.command.tasks")
local help = rewind.lazy_load("rewind.command.help")

M.list = {
	boards = boards,
	lists = lists,
	tasks = tasks,
	help_min = help,
	help_max = help,
}

function M.get_items(key)
	local content = {}
	if M.list[key] ~= nil then
		local items, raw_items = M.list[key].get_items()
		if items and #items > 0 then
			content = items
		end
	end
	util.buf.set_var(key, raw_items)
	util.buf.set_content(key, content)
end

function M.add_item(key, title)
	local content = {}
	if M.list[key] ~= nil and title then
		local success = M.list[key].add_item(title)
		print(success)
		if success then
			local items = M.list[key].get_items()
			if items and #items > 0 then
				content = items
			end
			print(vim.inspect(content))
			util.buf.set_content(key, content)
		end
	end
end

return M
