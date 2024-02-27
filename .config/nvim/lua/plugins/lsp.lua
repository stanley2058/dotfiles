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
                    require("none-ls.code_actions.eslint_d"),
                    require("none-ls.diagnostics.eslint_d"),
                    require("none-ls.formatting.eslint_d"),
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
    {
        "jay-babu/mason-null-ls.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                "prettierd",
                "eslint_d",
                "sql_formatter",
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                "prettierd",
                "lua-language-server",
                "bash-language-server",
                "rust-analyzer",
                "gopls",
                "typescript-language-server",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            format = {
                timeout_ms = 5000,
            },
            inlay_hints = {
                enabled = false,
            },
            servers = {
                tsserver = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(...)
                    end,
                },
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                },
                yamlls = {
                    css = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                    scss = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                    less = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                    keyOrdering = false,
                },
                typos_lsp = {
                    config = {
                        -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
                        cmd_env = { RUST_LOG = "error" },
                    },
                    init_options = {
                        -- Custom config. Used together with any workspace config files, taking precedence for
                        -- settings declared in both. Equivalent to the typos `--config` cli argument.
                        -- config = "~/code/typos-lsp/crates/typos-lsp/tests/typos.toml",
                        -- How typos are rendered in the editor, eg: as errors, warnings, information, or hints.
                        -- Defaults to error.
                        diagnosticSeverity = "Hint",
                    },
                },
            },
        },
    },
    {
        "simrat39/rust-tools.nvim",
        event = "VeryLazy",
        opts = {
            server = {
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy",
                        },
                    },
                },
            },
        },
    },
}
