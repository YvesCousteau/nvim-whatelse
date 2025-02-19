local api = vim.api
local rewind = require("rewind")
local M = {}

M.boards = rewind.lazy_load("rewind.ui.boards")
M.lists = rewind.lazy_load("rewind.ui.lists")
M.tasks = rewind.lazy_load("rewind.ui.tasks")
M.input = rewind.lazy_load("rewind.ui.input")
M.help = rewind.lazy_load("rewind.ui.help")

--------------------------------------------------
-- Helper Functions
--------------------------------------------------
local function init_window()
	rewind.state.buf.boards = api.nvim_create_buf(false, true)
	rewind.state.buf.lists = api.nvim_create_buf(false, true)
	rewind.state.buf.tasks = api.nvim_create_buf(false, true)
	rewind.state.buf.help = api.nvim_create_buf(false, true)
	rewind.state.buf.input = api.nvim_create_buf(false, true)

	M.boards.create_window()
	M.lists.create_window()
	M.tasks.create_window()

	rewind.state.help_init()
	M.help.open_window()

	rewind.autocmd.setup()

	rewind.util.update_content("boards")
	rewind.ui.boards.setup()
end

--------------------------------------------------
-- Public Functions
--------------------------------------------------
function M.is_window_open(win)
	if win and api.nvim_win_is_valid(win) then
		return true
	else
		return false
	end
end

function M.close_window(win)
	if M.is_window_open(win) then
		api.nvim_win_close(win, true)
		win = nil
	end
end

function M.close_all_window()
	for _, win in pairs(rewind.state.win.static) do
		if M.is_window_open(win) then
			M.close_window(win)
		end
	end
	for _, win in pairs(rewind.state.win.floating) do
		if M.is_window_open(win) then
			M.close_window(win)
		end
	end
end

function M.toggle_ui()
	local win_is_open = false
	for _, win in pairs(rewind.state.win.static) do
		if M.is_window_open(win) then
			M.close_window(win)
			win_is_open = true
		end
	end
	for _, win in pairs(rewind.state.win.floating) do
		if M.is_window_open(win) then
			M.close_window(win)
			win_is_open = true
		end
	end
	if not win_is_open then
		init_window()
	end
end

function M.create_window(buf, type, win, pos, is_focused, is_modifiable)
	local width = math.floor(vim.o.columns * rewind.config.options.ui.width_percentage)
	local height = math.floor(vim.o.lines * rewind.config.options.ui.height_percentage)
	win[type] = api.nvim_open_win(buf[type], is_focused, {
		relative = "editor",
		width = math.floor(width * pos.width_mult),
		height = math.floor(height * pos.height_mult),
		col = math.floor(width * pos.col_mult),
		row = math.floor(height * pos.row_mult),
		title = pos.title,
		title_pos = pos.layout,
		style = "minimal",
		border = "rounded",
		zindex = pos.zindex,
	})
	api.nvim_buf_set_option(buf[type], "modifiable", is_modifiable)

	rewind.keymaps.setup(buf, win, type)
end

return M
