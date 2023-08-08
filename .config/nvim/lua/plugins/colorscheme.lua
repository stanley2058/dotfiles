return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
            require("catppuccin").setup()
            vim.cmd([[colorscheme catppuccin]])
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        opts = {
            ["*"] = { names = false }, -- Highlight all files, but customize some others.
            css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
        },
    },
}
