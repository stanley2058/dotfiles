-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

wk.register({
    d = {
        '"_d',
        "Delete to void",
    },
    x = {
        ["+"] = {
            "<cmd>!chmod +x %<CR>",
            "Mark file executable",
        },
    },
}, { prefix = "<leader>" })
wk.register({
    d = {
        '"_d',
        "Delete to void",
    },
}, { prefix = "<leader>", mode = "v" })
