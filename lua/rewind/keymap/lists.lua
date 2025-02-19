local M = {}
local rewind = require("rewind")
local config = rewind.config
local keymap = rewind.keymap
local util = rewind.util
local ui = rewind.ui

function M.setup()
	local key = "lists"
	keymap.util.set(key, "n", { config.keymaps.select }, function()
		if util.buf.is_empty("tasks") then
			util.switch_window("tasks")
		else
			ui.prompt.toggle_window("prompt")
		end
	end)

	keymap.util.set(key, "n", { config.keymaps.back }, function()
		util.switch_window("boards")
	end)
end

return M
