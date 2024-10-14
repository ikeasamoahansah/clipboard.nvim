local M = {}

-- @type Config
M.values = {
    text_hist_num = 10,
    command_yank_history = "YankH"
}

-- @param opts Config
function M.setup(opts)
    if opts then
        for k, v in pairs(opts) do
            if M.values[k] ~= nil then
                M.values[k] = v
            end
        end
    end
end

return M
