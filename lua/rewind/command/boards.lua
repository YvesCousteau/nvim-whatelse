local M = {}
local rewind = require("rewind")
local data = rewind.data
local util = rewind.util

function M.get_items()
	local titles = {}
	local data = data.load_items()
	if data then
		for _, board in ipairs(data) do
			table.insert(titles, board.title)
		end
	end
	return titles, data
end

function M.add_item(title)
	local new_item = {
		uuid = util.uuid(),
		title = title,
		lists = {},
	}
	return data.add_item(new_item)
end

-- function M.delete_item(id)
-- 	return data.delete_item(uuid)
-- end

return M
