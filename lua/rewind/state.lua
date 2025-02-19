local M = {
	list = {
		"boards",
		"lists",
		"tasks",
		"prompt",
		"confirmation",
		"date_picker",
	},

	namespace = nil,
	prev_buf = nil,
	prompt = {
		key = nil,
		callback = nil,
	},

	uuid_map = {},
}

return M
