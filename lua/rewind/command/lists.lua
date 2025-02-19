local M = {}
local data = require("rewind").data

function M.get_items()
	local titles = {}
	local data = data.load_items()
	if data then
		-- need to check for current board
		for _, board in ipairs(data) do
			for _, list in ipairs(board.lists) do
				table.insert(titles, list.title)
			end
		end
	end
	return titles, {}
end

return M
