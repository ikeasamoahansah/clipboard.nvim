local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local clipconf = require("clipboard.config")

local clipboard_history = {}

local hist_num = clipconf.values.text_hist_num

function M.update_clipboard_history()
	local clipboard_content = vim.fn.getreg("0")

	table.insert(clipboard_history, 1, clipboard_content)
	if #clipboard_history > hist_num then
		table.remove(clipboard_history, hist_num + 1)
	end
end

function M.show_clipboard(opts)
	opts = opts or {}

	pickers
		.new(opts, {
			finder = finders.new_table({
				results = clipboard_history,

				entry_maker = function(entry)
					return {
						value = entry,
						display = entry:sub(1, 10),
						ordinal = entry,
					}
				end,
			}),
			sorter = config.generic_sorter(opts),

			previewer = previewers.new_buffer_previewer({
				title = "Check Clipboard Entries",
				define_preview = function(self, entry)
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(entry.value, "\n"))
					utils.highlighter(self.state.bufnr, "markdown")
				end,
			}),

			-- func for selecting the yanked snippet and putting it in "
			attach_mappings = function(_, map)
				map("i", "<CR>", function(prompt_bufnr)
					local entry = action_state.get_selected_entry()
					actions.close(prompt_bufnr)

					-- put the selected yanked snippet in " register for pasting with p/P
					vim.fn.setreg("0", entry.value)
				end)

				return true
			end,
		})
		:find()
end

return M
