local M = {}
local rewind = require("rewind")
local util = rewind.util

function M.set(key, events, callback)
	local buf = util.buf.get(key)
	if buf then
		if type(events) == "table" and #events > 0 then
			for _, event in pairs(events) do
				vim.api.nvim_clear_autocmds({
					event = event,
					buffer = buf,
				})
			end
			vim.api.nvim_create_autocmd(events, {
				buffer = buf,
				callback = callback,
			})
		else
			print("Unable to set a autocmd " .. vim.inspect(events) .. " for buffer " .. key)
		end
	else
		print("No buffer found " .. key .. " for autocmds " .. vim.inspect(events))
	end
end

return M
