local M = {}

local config = require("clipboard.config")
local core = require("clipboard.core")

local function setup_commands()
    -- clear=true wipes any autocmds in this group from previous setup() calls
    local group = vim.api.nvim_create_augroup("ClipboardNvim", { clear = true })
    vim.api.nvim_create_autocmd("TextYankPost", {
        group = group,
        callback = core.update_clipboard_history,
    })
    vim.api.nvim_create_user_command(config.values.command_yank_history, function()
        -- pass a fresh table (not the user-command opts) so nothing
        -- unexpected ends up in the telescope picker
        core.show_clipboard({})
    end, { desc = "View recently yanked scripts" })
end



--- intialize plugin
---@param opts Config
function M.setup(opts)
    config.setup(opts)
    setup_commands()
end

return M
