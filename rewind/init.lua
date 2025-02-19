local api = vim.api
local M = {}

function M.lazy_load(module_name)
	return setmetatable({}, {
		__index = function(_, key)
			return require(module_name)[key]
		end,
	})
end

M.state = M.lazy_load("rewind.state")
M.util = M.lazy_load("rewind.util")
M.ui = M.lazy_load("rewind.ui")
M.config = M.lazy_load("rewind.config")
M.controller = M.lazy_load("rewind.controller")
M.autocmd = M.lazy_load("rewind.autocmd")
M.keymaps = M.lazy_load("rewind.keymaps")
M.formatting = M.lazy_load("rewind.formatting")

function M.setup(opts)
	M.config.setup(opts)
	api.nvim_create_user_command("RewindToggle", M.ui.toggle_ui, {})
end

return M
