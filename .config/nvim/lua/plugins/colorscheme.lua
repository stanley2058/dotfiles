return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
            flavour = "mocha",
            intergations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                noice = true,
                notify = true,
                which_key = true,
            },
        },
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
