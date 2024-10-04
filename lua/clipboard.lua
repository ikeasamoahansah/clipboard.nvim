local M = {}
local clipboard_history = {}

local function update_clipboard_history()
    local clipboard_content = vim.fn.getreg("0")

    table.insert(clipboard_history, 1, clipboard_content)
    if #clipboard_history > 10 then
        table.remove(clipboard_history, 11)
    end
end


local function show_clipboard(opts)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local config = require("telescope.config").values
    local previewers = require("telescope.previewers")
    local utils = require("telescope.previewers.utils")

    opts = opts or {}
    pickers
        .new(opts, {
            finder = finders.new_table({
                results = clipboard_history,

                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = "0",
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
                        -1,
                        false,
                        vim.tbl_flatten({
                            "``` lua",
                                vim.split(entry.value, "\n"),
                            "```",
                        })
                    )
                    utils.highlighter(self.state.bufnr, "markdown")
                end,
            })
        })
        :find()
end


function M.setup()
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = update_clipboard_history
    })

    vim.api.nvim_create_user_command("YankH", show_clipboard, {})
end

return M
