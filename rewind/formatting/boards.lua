local api = vim.api
local rewind = require("rewind")
local M = {}

function M.setup(content)
	local active_icon = rewind.config.options.formatting.boards.is_active.icon
	local inactive_icon = rewind.config.options.formatting.boards.is_inactive.icon
	local icon = ""
	if rewind.state.get_current("board") == content.title then
		icon = active_icon
	else
		icon = inactive_icon
	end
	return icon .. content.title
end

function M.reverse(content)
	local active_icon = rewind.config.options.formatting.boards.is_active.icon
	local inactive_icon = rewind.config.options.formatting.boards.is_inactive.icon
	content = content:gsub("^" .. vim.pesc(active_icon), "")
	content = content:gsub("^" .. vim.pesc(inactive_icon), "")
	content = content:match("^%s*(.-)%s*$")
	return content
end

return M
