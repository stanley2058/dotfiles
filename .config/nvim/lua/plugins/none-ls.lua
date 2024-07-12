return {
    {
        "nvimtools/none-ls-extras.nvim",
    },
    {
        "nvimtools/none-ls.nvim",
        opts = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.sql_formatter,
                    null_ls.builtins.formatting.shfmt.with({
                        args = {
                            "--indent",
                            4,
                        },
                    }),
                    null_ls.builtins.formatting.google_java_format,
                },
            })
            require("crates").setup({
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
            })
        end,
    },
}
