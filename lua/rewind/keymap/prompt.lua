local M = {}
local rewind = require("rewind")
local config = rewind.config
local keymap = rewind.keymap
local util = rewind.util
local ui = rewind.ui

function M.setup()
	local key = "prompt"
	keymap.util.set(key, "n", { config.keymaps.back }, function()
		ui.prompt.toggle_window(key)
	end)

	keymap.util.set(key, "i", { config.keymaps.back }, function()
		ui.prompt.toggle_window(key)
	end)

	keymap.util.set(key, "i", { config.keymaps.select }, function()
		ui.prompt.toggle_window(key)
	end)
end

return M
