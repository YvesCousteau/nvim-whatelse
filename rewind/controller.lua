local rewind = require("rewind")
local M = {}

M.boards = rewind.lazy_load("rewind.controller.boards")
M.lists = rewind.lazy_load("rewind.controller.lists")
M.tasks = rewind.lazy_load("rewind.controller.tasks")
M.help = rewind.lazy_load("rewind.controller.help")

function M.find_data(content_type, callback)
	local content = rewind.util.load_json_file(rewind.config.options.file_path)
	if not content then
		return error("Error: No content loaded")
	end

	local current_board = rewind.state.get_current("board")
	local current_list = rewind.state.get_current("list")
	local current_task = rewind.state.get_current("task")

	local select_board = nil
	local select_list = nil
	local select_task = nil

	local index, item = nil

	local excluded_types = { "boards", "lists", "tasks", "board", "list", "task" }
	if not table.concat(excluded_types, ","):find(content_type) then
		return error("Invalid type")
	end

	if content_type == "boards" then
		item = content
	elseif current_board then
		for board_index, board in ipairs(content) do
			if board.title and board.title == current_board then
				select_board = board
				if content_type == "board" then
					index = board_index
					item = board
				elseif board.lists then
					if content_type == "lists" then
						item = board.lists
					elseif current_list then
						for list_index, list in ipairs(board.lists) do
							if list.title and list.title == current_list then
								select_list = list
								if content_type == "list" then
									index = list_index
									item = list
								elseif list.tasks then
									if content_type == "tasks" then
										item = list.tasks
									elseif current_task then
										for task_index, task in ipairs(list.tasks) do
											if task.title and task.title == current_task then
												select_task = task
												if content_type == "task" then
													index = task_index
													item = task
												else
													return error(
														"Invalid task for task "
															.. current_task
															.. " of list "
															.. current_list
															.. " of board "
															.. current_board
													)
												end
											end
										end
									else
										return error(
											"Invalid current task for list "
												.. current_list
												.. " of  board "
												.. current_board
										)
									end
								else
									return error(
										"Invalid tasks for list " .. current_list .. " of board " .. current_board
									)
								end
							end
						end
					else
						return error("Invalid current list for  board " .. current_board)
					end
				else
					return error("Invalid lists for board " .. current_board)
				end
			end
		end
	end

	return callback(content, index, item)
end

local function get(content_type)
	local item = M.find_data(content_type, function(_, _, item)
		return item
	end)
	if item then
		return item
	else
		return {}
	end
end

local function set(content_type, input)
	if not input or input == "" then
		return nil
	end

	M.find_data(content_type, function(content, _, item)
		if item then
			item.title = input
			local success = rewind.util.save_json_file(rewind.config.options.file_path, content)
			if not success then
				return error("Failed to save content")
			end
		end
	end)
end

local function add(content_type, input)
	if not input or input == "" then
		return nil
	end

	M.find_data(content_type, function(content, _, item)
		if item and type(item) == "table" then
			table.insert(item, rewind.state.default_format[content_type:sub(1, -2)])
			item[#item].title = input
			local success = rewind.util.save_json_file(rewind.config.options.file_path, content)
			if not success then
				return error("Failed to save content")
			end
		end
	end)
end

local function delete(content_type)
	-- M.find_data(content_type, function(_, item, content)
	-- 	if item and type(item) == "table" then
	-- 		table.insert(item, rewind.state.default_format[content_type:sub(1, -2)])
	-- 		item[#item].title = input
	-- 		local success = rewind.util.save_json_file(rewind.config.options.file_path, content)
	-- 		if not success then
	-- 			print("Error: save content")
	-- 		end
	-- 	end
	-- end)
	--
	-- local _, parent = M.find_data(content_type .. "s")
	-- if not parent then
	-- 	return nil
	-- end
	--
	-- local index, item = M.find_data(content_type)
	-- if not item then
	-- 	return nil
	-- end
	-- table.remove(parent, index)
end

function M.get(content_type)
	local content = get(content_type)
	if content and #content > 0 then
		local formatted_content = {}
		for _, item in ipairs(content) do
			table.insert(formatted_content, item.title)
		end
		rewind.state.set_current(content_type, formatted_content)
	else
		rewind.state.set_current(content_type, {})
	end
end

function M.get_first(content_type)
	local content = get(content_type)
	if content and #content > 0 then
		local first_list = content[1].title
		if first_list then
			return first_list
		end
	end
end

function M.set(content_type, input)
	if set(content_type, input) then
		rewind.util.update_content(content_type .. "s")
	end
end

function M.add(content_type, input)
	if add(content_type, input) then
		rewind.util.update_content(content_type)
	end
end

function M.delete(content_type)
	if delete(content_type) then
		rewind.util.update_content(content_type .. "s")
	end
end

function M.reload()
	rewind.util.clear_highlights(rewind.state.buf, rewind.state.namespace.highlight)
	for key, _ in pairs(rewind.state.win.static) do
		rewind.util.update_content(key)
	end
end

return M
