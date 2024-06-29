local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")

M.show_clipboard = function()
    pickers
        .new(opts, {
            finder = finders.new_async_job({
                command_generator = function()
                    return {"ls"}
                end,

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
                    vim.api.nvim_buf_set_lines(
                        self.state.bufnr,
                        0,
                        0,
                        true,
                        vim.tbl_flatten({
                            "```lua",
                            vim.split(vim.inspect(entry.value), '\n'),
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
