local M = {}
local rewind = require("rewind")
local config = rewind.config
local keymap = rewind.keymap
local util = rewind.util
local ui = rewind.ui
local command = rewind.command

function M.setup()
	local key = "boards"
	keymap.util.set(key, "n", { config.keymaps.select }, function()
		if util.buf.is_empty("lists") then
			util.switch_window("lists")
		else
			ui.prompt.toggle_window("prompt")
		end
	end)

	keymap.util.set(key, "n", { config.keymaps.back }, function()
		ui.util.close_all_window()
	end)

	keymap.util.set(key, "n", { config.keymaps.add }, function()
		command.add_item(key, "sexe")
	end)
end

return M
