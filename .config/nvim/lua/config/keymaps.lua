-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

local commonMapping = {
    d = {
        '"_d',
        "Delete to void",
    },
    g = {
        -- browse
        l = {
            "<cmd>GitLink<cr>",
            "Copy git permlink to clipboard",
        },
        L = {
            "<cmd>GitLink!<cr>",
            "Open git permlink in browser",
        },
        -- blame
        b = {
            "<cmd>GitLink blame<cr>",
            "Copy git blame link to clipboard",
        },
        B = {
            "<cmd>GitLink! blame<cr>",
            "Open git blame link in browser",
        },
    },
}

wk.register(commonMapping, { prefix = "<leader>" })
wk.register(commonMapping, { prefix = "<leader>", mode = "v" })
wk.register({
    x = {
        ["+"] = {
            "<cmd>!chmod +x %<CR>",
            "Mark file executable",
        },
    },
}, { prefix = "<leader>" })
