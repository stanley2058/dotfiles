-- tailwind-tools.lua
return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "neovim/nvim-lspconfig", -- optional
    },
    ---@type TailwindTools.Option
    opts = {
        server = {
            settings = {
                experimental = {
                    classRegex = {
                        { "cm\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
                        { "(?:twMerge|twJoin)\\(([^;]*)[\\);]", "[`'\"`]([^'\"`;]*)[`'\"`]" },
                    },
                },
            },
        },
    }, -- your configuration
}
