-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

wk.add({
    {
        mode = { "n", "v" },
        { "<leader>d", '"_d', desc = "Delete to void" },
        -- link
        { "<leader>gl", "<cmd>GitLink<cr>", desc = "Copy git permlink to clipboard" },
        { "<leader>gL", "<cmd>GitLink!<cr>", desc = "Open git permlink in browser" },
        -- blame
        { "<leader>gb", "<cmd>GitLink blame<cr>", desc = "Copy git blame link to clipboard" },
        { "<leader>gB", "<cmd>GitLink! blame<cr>", desc = "Open git blame link in browser" },
    },
    { "<leader>x+", "<cmd>!chmod +x %<CR>", desc = "Mark file executable" },
})
