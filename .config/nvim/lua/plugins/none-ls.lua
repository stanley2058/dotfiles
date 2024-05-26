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
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.sql_formatter,
                    null_ls.builtins.formatting.shfmt.with({
                        args = {
                            "--indent",
                            4,
                        },
                    }),
                    null_ls.builtins.formatting.google_java_format,
                    require("none-ls.code_actions.eslint_d").with({
                        condition = function(utils)
                            return utils.root_has_file({
                                ".eslintrc",
                                ".eslintrc.cjs",
                                ".eslintrc.yaml",
                                ".eslintrc.yml",
                                ".eslintrc.json",
                            })
                        end,
                    }),
                    require("none-ls.diagnostics.eslint_d").with({
                        condition = function(utils)
                            return utils.root_has_file({
                                ".eslintrc",
                                ".eslintrc.cjs",
                                ".eslintrc.yaml",
                                ".eslintrc.yml",
                                ".eslintrc.json",
                            })
                        end,
                    }),
                    require("none-ls.formatting.eslint_d").with({
                        condition = function(utils)
                            return utils.root_has_file({
                                ".eslintrc",
                                ".eslintrc.cjs",
                                ".eslintrc.yaml",
                                ".eslintrc.yml",
                                ".eslintrc.json",
                            })
                        end,
                    }),
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
