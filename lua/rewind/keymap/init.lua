local M = {}
local rewind = require("rewind")
local config = rewind.config
local ui = rewind.ui
local help = rewind.lazy_load("rewind.keymap.help")
local prompt = rewind.lazy_load("rewind.keymap.prompt")
local boards = rewind.lazy_load("rewind.keymap.boards")
local lists = rewind.lazy_load("rewind.keymap.lists")
local tasks = rewind.lazy_load("rewind.keymap.tasks")
M.util = rewind.lazy_load("rewind.keymap.util")

M.list = {
	help_min = help,
	help_max = help,
	prompt = prompt,
	boards = boards,
	lists = lists,
	tasks = tasks,
}

local function common(key)
	M.util.set(key, "n", { config.keymaps.help }, function()
		ui.help.toggle_window("help_min")
		ui.help.toggle_window("help_max")
	end)
end

function M.setup(key)
	if M.list[key] ~= nil then
		M.list[key].setup()
	end
	common(key)
end

return M
