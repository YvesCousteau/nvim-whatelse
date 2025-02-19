local api = vim.api
local rewind = require("rewind")
local M = {}

--------------------------------------------------
-- Helper Functions
--------------------------------------------------

--------------------------------------------------
-- Public Functions
--------------------------------------------------
function M.load_json_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end
	local content = file:read("*all")
	file:close()

	local success, decoded = pcall(vim.json.decode, content)
	if not success then
		return error("Invalid JSON in file " .. path)
	end

	if not decoded or type(decoded) ~= "table" then
		return error("Failed to load JSON file or invalid data")
	end

	return decoded
end

function M.save_json_file(path, data)
	local file = io.open(path, "w")
	if not file then
		return error("Unable to open file for writing at " .. path)
	end

	local success, encoded = pcall(vim.json.encode, data)
	if not success then
		file:close()
		return error("Unable to encode data to JSON")
	end

	if not encoded then
		return error("Failed to load table")
	end

	file:write(encoded)
	file:close()
	return true
end

function M.clear_highlights(buf, namespace)
	for _, buffer_id in pairs(buf) do
		api.nvim_buf_clear_namespace(buffer_id, namespace, 0, -1)
	end
end

function M.update_highlight(buf, namespace)
	api.nvim_buf_clear_namespace(buf, namespace, 0, -1)
	local current_line = api.nvim_win_get_cursor(0)[1] - 1
	api.nvim_buf_add_highlight(buf, namespace, "Visual", current_line, 0, -1)
end

function M.update_content(content_type)
	local success, formatted_content = pcall(function()
		rewind.formatting.setup(content_type)
	end)
	if not success then
		return error("Formated content " .. content_type .. " failed")
	else
		if formatted_content and type(formatted_content) ~= "table" then
			local success, result = pcall(function()
				api.nvim_buf_set_option(rewind.state.buf[content_type], "modifiable", true)
				api.nvim_buf_set_lines(rewind.state.buf[content_type], 0, -1, false, formatted_content)
				api.nvim_buf_set_option(rewind.state.buf[content_type], "modifiable", false)
			end)
			if not success then
				return error("Failed to pdate content due to " .. result)
			end
		end
	end
end

function M.get_current_line(content_type)
	local current_line = api.nvim_get_current_line()
	return rewind.formatting.reverse(content_type, current_line)
end

function M.is_buffer_empty(buf)
	local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
	return #lines == 0 or (#lines == 1 and lines[1] == "")
end

function M.get_buffer_type(buf_table, buffer)
	for key, value in pairs(buf_table) do
		if value == buffer then
			return key
		end
	end
	return nil
end

function M.set_keymap(buf, mode, key, callback, opts)
	opts = vim.tbl_extend("force", {
		noremap = true,
		silent = true,
		callback = callback,
	}, opts or {})
	api.nvim_buf_set_keymap(buf, mode, key, "", opts)
end

return M
