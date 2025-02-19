-- In config.lua, add PRIORITIES to the defaults
local M = {}

M.defaults = {
	file_path = "/path/to/save/todo.json",
	ui = {
		width_percentage = 0.8,
		height_percentage = 0.8,
		position = {
			boards = {
				title = " 󱁳 BOARDS ",
				width_mult = 0.25,
				height_mult = 0.5,
				col_mult = 0.24,
				row_mult = 0.35,
				layout = "center",
				zindex = 100,
			},
			lists = {
				title = " 󰉺 LISTS ",
				width_mult = 0.25,
				height_mult = 0.5,
				col_mult = 0.5,
				row_mult = 0.35,
				layout = "center",
				zindex = 100,
			},
			tasks = {
				title = " 󰸞 TASKS ",
				width_mult = 0.25,
				height_mult = 0.5,
				col_mult = 0.76,
				row_mult = 0.35,
				layout = "center",
				zindex = 100,
			},
			input = {
				title = " |> INPUT ",
				width_mult = 0.2,
				height_mult = 0.03,
				col_mult = 0.525,
				row_mult = 0.5,
				layout = "left",
				zindex = 200,
			},
			help_collapse = {
				title = " 󰋖 HELP ",
				width_mult = 0.055,
				height_mult = 0.03,
				col_mult = 0.24,
				row_mult = 0.295,
				layout = "center",
				zindex = 100,
			},
			help_expand = {
				title = " 󰋖 HELP - Expanded ",
				width_mult = 0.2,
				height_mult = 0.2,
				col_mult = 0.525,
				row_mult = 0.5,
				layout = "center",
				zindex = 200,
			},
		},
	},
	keymaps = {
		quit = "q",
		back = "<Esc>",
		select = "<CR>",
		help = "h",
		add = "a",
		delete = "d",
		update = "u",

		-- toggle_window = "<leader>td",
		-- new_todo = "i",
		-- toggle_todo = "x",
		-- delete_todo = "d",
		-- delete_completed = "D",
		-- close_window = "q",
		-- undo_delete = "u",
		-- add_due_date = "H",
		-- remove_due_date = "r",
		-- toggle_help = "?",
		-- toggle_tags = "t",
		-- toggle_priority = "<Space>",
		-- clear_filter = "c",
		-- edit_todo = "e",
		-- edit_tag = "e",
		-- edit_priorities = "p",
		-- delete_tag = "d",
		-- share_todos = "s",
		-- search_todos = "/",
		-- add_time_estimation = "T",
		-- remove_time_estimation = "R",
		-- import_todos = "I",
		-- export_todos = "E",
		-- remove_duplicates = "<leader>D",
		-- open_todo_scratchpad = "<leader>p",
	},
	formatting = {
		boards = {
			is_active = {
				icon = "   ",
			},
			is_inactive = {
				icon = "   ",
			},
		},
		lists = {
			is_active = {
				icon = "   ",
			},
			is_inactive = {
				icon = "   ",
			},
		},
		tasks = {
			date = {
				is_defined = {
					icon = "  ",
				},
				is_undefined = {
					icon = "  ",
				},
			},
			state = {
				todo = {
					icon = " 󰽤 ",
				},
				doing = {
					icon = " 󰪡 ",
				},
				done = {
					icon = " 󰪥 ",
				},
			},
		},
	},
}

M.options = {}

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
