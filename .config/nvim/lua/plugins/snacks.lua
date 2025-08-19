return {
    "snacks.nvim",
    ---@type snacks.Config
    opts = {
        scroll = { enabled = false },
        notifier = {
            level = vim.log.levels.INFO,
        },
        bigfile = {
            size = 2 * 1024 * 1024,
            line_length = 5000,
        },
    },
}
