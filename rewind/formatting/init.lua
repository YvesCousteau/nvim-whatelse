local api = vim.api
local rewind = require("rewind")
local M = {}

M.boards = rewind.lazy_load("rewind.formatting.boards")
M.lists = rewind.lazy_load("rewind.formatting.lists")
M.tasks = rewind.lazy_load("rewind.formatting.tasks")

function M.setup(content_type)
	local success, result = pcall(function()
		return rewind.controller.find_data(content_type, function(_, _, item)
			if item and type(item) == "table" then
				if content_type:sub(-1) == "s" then
					local formatted_content = {}
					for _, item in ipairs(item) do
						table.insert(formatted_content, M[content_type].setup(item))
					end
					return formatted_content
				else
					return M[content_type:sub(1, -2)].setup(item)
				end
			else
				return item
			end
		end)
	end)
	if success then
		return result
	else
		local current_content = rewind.state.get_current(content_type)
		if current_content then
			return current_content
		else
			return error("Current content is null " .. content_type .. ": " .. vim.inspect(current_content))
		end
	end
end

function M.reverse(content_type, content)
	if content then
		if type(content) == "table" then
			local unformatted_content = {}
			for _, item in ipairs(content) do
				table.insert(unformatted_content, M[content_type].reverse(item))
			end
			return unformatted_content
		elseif type(content) == "string" then
			return M[content_type .. "s"].reverse(content)
		else
			return content
		end
	end
end

return M
