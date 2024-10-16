local M = {}

local config = require("clipboard.config")
local core = require("clipboard.core")

local function setup_commands(opts)
    vim.api.nvim_create_autocmd("TextYankPost", {
		    callback = function () core.update_clipboard_history(opts) end,
    })
    vim.api.nvim_create_user_command(opts.command_yank_history, core.show_clipboard, {})
end



--- intialize plugin
---@param opts Config
function M.setup(opts)
    config.setup(opts)
    setup_commands(opts)
end

return M
