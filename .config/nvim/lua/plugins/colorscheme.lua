return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
            flavour = "mocha",
            auto_integrations = true,
            custom_highlights = function(colors)
                return {
                    Operator = { fg = colors.mauve },
                    ["@variable.member"] = { fg = colors.lavender },
                    ["@property"] = { fg = colors.lavender },
                    ["@keyword.export"] = { fg = colors.sky },
                }
            end,
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
            scss = { rgb_fn = true },
        },
    },
}
