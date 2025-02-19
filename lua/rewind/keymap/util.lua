local M = {}
local util = require("rewind").util

function M.set(key, mode, keymaps, callback, opts)
	local buf = util.buf.get(key)
	if buf then
		if type(keymaps) == "table" and #keymaps > 0 then
			opts = vim.tbl_extend("force", {
				noremap = true,
				silent = true,
				callback = callback,
			}, opts or {})
			for _, keymap in pairs(keymaps) do
				vim.api.nvim_buf_set_keymap(buf, mode, keymap, "", opts)
			end
		else
			print("Unable to set a keymaps " .. vim.inspect(keymaps) .. " on mode " .. mode .. " for buffer " .. key)
		end
	else
		print("No buffer found " .. key .. " for keymaps " .. vim.inspect(keymaps))
	end
end

return M
