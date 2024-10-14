local M = {}

local config = require("clipboard.config")
local core = require("clipboard.core")

local function setup_commands()
    vim.api.nvim_create_autocmd("TextYankPost", {
		    callback = core.update_clipboard_history,
    })
    vim.api.nvim_create_user_command(config.values.command_yank_history, core.show_clipboard, {})
end



-- intialize plugin
-- @param opts Config
function M.setup(opts)
    config.setup(opts)
    setup_commands()
end

return M
