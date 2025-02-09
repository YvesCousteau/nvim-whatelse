local api = vim.api
local rewind = require("rewind")
local M = {}

M.buf = {
	boards = nil,
	lists = nil,
	tasks = nil,
	help = nil,
	input = nil,
}

M.win = {
	static = {
		boards = nil,
		lists = nil,
		tasks = nil,
	},
	floating = {
		help = nil,
		input = nil,
	},
}

M.namespace = {
	highlight = api.nvim_create_namespace("HighlightNamespace"),
}

M.current = {
	board = nil,
	boards = nil,
	list = nil,
	lists = nil,
	task = nil,
	tasks = nil,
}

function M.get_current(content_type)
	return M.current[content_type]
end

function M.set_current(content_type, content)
	local unformated_content = rewind.formatting.reverse(content_type, content)
	-- local unformated_content = content
	if unformated_content then
		M.current[content_type] = unformated_content
	else
		M.current[content_type] = content
	end
	return M.current[content_type]
end

M.default_format = {
	board = {
		title = "UNDEFINED",
		lists = {},
	},
	list = {
		title = "UNDEFINED",
		tasks = {},
	},
	task = {
		title = "UNDEFINED",
		state = "TODO",
		date = "UNDEFINED",
	},
}

M.help = {
	is_expanded = true,
	type = nil,
	collapse = {
		init = {
			'Press - "h"',
		},
	},
	expanded = {
		init = {
			"Rewind Plugin Help",
			"",
			"Navigation:",
			"  j/k   - Move up/down",
			"  q     - Close windows",
			"  h     - Show/Hide help",
			"",
			"Windows:",
			"  Boards - Select a Board",
			"  Lists  - View Lists in a board",
			"  Tasks  - View Tasks in a list",
			"",
			"Commands:",
			"  :RewindToggle - Toggle Rewind UI",
			"",
		},
		boards = {
			"------------- Boards -------------",
			"",
			"Navigation:",
			"  Esc   - Close windows",
			"  Enter - Go to selected List items",
			"  a     - Create new Board",
			"  d     - Delete selected Board",
			"  u     - Update selected Board",
		},
		lists = {
			"------------- Lists --------------",
			"in => ",
			"",
			"Navigation:",
			"  Esc   - Go back to previous Boards",
			"  Enter - Go to selected Tasks items",
			"  a     - Create new List",
			"  d     - Delete selected List",
			"  u     - Update selected List",
		},
		tasks = {
			"------------- Tasks --------------",
			"",
			"Navigation:",
			"  Esc   - Go back to previous Lists",
			"  Enter - Update selected Task",
			"  a     - Create new Task",
			"  d     - Delete selected Task",
			"  u     - Update selected Task",
		},
	},
}

function M.help_toggle()
	M.help.is_expanded = not M.help.is_expanded
	if M.help.is_expanded then
		local updated_content = vim.deepcopy(M.help.expanded.init)
		local type = M.help.type
		if type and M.help.expanded[type] then
			for _, line in ipairs(M.help.expanded[type]) do
				table.insert(updated_content, line)
			end
		end
		M.set_current("help", updated_content)
	else
		M.set_current("help", M.help.collapse.init)
	end
end

return M
