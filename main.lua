local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")

local function get_clipboard_cont()
    local clipboard = vim.fn.getreg("+")
    return clipboard
end

M.show_clipboard = function()
    pickers
        .new(opts, {
            finder = finders.new_table({
                results = {"Clipboard content"},

                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry,
                        ordinal = entry
                    }
                end
            }),
            sorter = config.generic_sorter(opts),

            previewer = previewers.new_buffer_previewer({
                title = "Check Clipboard Entries",
                define_preview = function (self, entry)
                    local clipboard_content = get_clipboard_cont()
                    vim.api.nvim_buf_set_lines(
                        self.state.bufnr,
                        0,
                        -1,
                        false,
                        vim.tbl_flatten({
                            "``` lua",
                            vim.split(clipboard_content, "\n"),
                            "```",
                        })
                    )
                    utils.highlighter(self.state.bufnr, "markdown")
                end,
            })
        })
        :find()
end

M.show_clipboard()

return M
