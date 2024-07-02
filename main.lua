local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")

local clipboard_history = {}

local function get_clipboard_cont()
    local clipboard = vim.fn.getreg("+")
    return clipboard
end

local function update_clipboard_history()
    local clipboard_content = get_clipboard_cont()
    if clipboard_content ~= clipboard_history[1] then
        table.insert(clipboard_history, 1, clipboard_content)
    end
    if #clipboard_history > 5 then
        table.remove(clipboard_history)
    end
end

update_clipboard_history()

M.show_clipboard = function(opts)
    opts = opts or {}
    pickers
        .new(opts, {
            finder = finders.new_table({
                results = clipboard_history,

                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry:sub(1, 5),
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

-- Set up an autocommand to update the clipboard history whenever the clipboard content changes
--vim.cmd([[
--    augroup ClipboardHistory
--        autocmd!
--        autocmd TextYankPost * lua require("clipboard_history").update_clipboard_history()
--    augroup END
--]])

-- Export the update_clipboard_history function so it can be called by the autocommand
M.update_clipboard_history = update_clipboard_history()
M.show_clipboard()

return M

