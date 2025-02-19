local M = {}
local rewind = require("rewind")
local config = rewind.config
local util = rewind.util

function M.get_items()
	local help_min_win = util.win.get("help_min")
	local help_max_win = util.win.get("help_max")
	if help_min_win then
		return config.help.min.init
	elseif help_max_win then
		local items = vim.deepcopy(config.help.max.init)
		local prev_buf = util.get_prev_buf()
		local prev_buf_help = config.help.max[prev_buf]
		if prev_buf and prev_buf_help ~= nil then
			for _, line in ipairs(config.help.max[prev_buf]) do
				table.insert(items, line)
			end
		end
		return items, {}
	end
end

return M
