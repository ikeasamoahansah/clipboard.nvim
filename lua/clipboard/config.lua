local M = {}

---@type Config
M.values = {
    history_size = 10,
    command_yank_history = "Yank"
}

---@param user_config Config
function M.setup(user_config)
    M.values = vim.tbl_deep_extend("force", M.values, user_config or {})
end

return M
