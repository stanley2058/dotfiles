local prettier_formatter = { "prettierd", "prettier" }
local eslint_formatter = { "eslint_d", "eslint" }

return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            timeout_ms = 5000,
        },
        formatters = {
            eslint_d = {
                require_cwd = true,
                cwd = require("conform.util").root_file({
                    ".eslintrc",
                    ".eslintrc.cjs",
                    ".eslintrc.yaml",
                    ".eslintrc.yml",
                    ".eslintrc.json",
                    "eslint.config.js",
                }),
            },
            eslint = {
                require_cwd = true,
                cwd = require("conform.util").root_file({
                    ".eslintrc",
                    ".eslintrc.cjs",
                    ".eslintrc.yaml",
                    ".eslintrc.yml",
                    ".eslintrc.json",
                    "eslint.config.js",
                }),
            },
        },
        formatters_by_ft = {
            ["javascript"] = { prettier_formatter, eslint_formatter },
            ["javascriptreact"] = { prettier_formatter, eslint_formatter },
            ["typescript"] = { prettier_formatter, eslint_formatter },
            ["typescriptreact"] = { prettier_formatter, eslint_formatter },
            ["vue"] = { prettier_formatter },
            ["css"] = { prettier_formatter },
            ["scss"] = { prettier_formatter },
            ["less"] = { prettier_formatter },
            ["html"] = { prettier_formatter },
            ["json"] = { prettier_formatter },
            ["jsonc"] = { prettier_formatter },
            ["yaml"] = { prettier_formatter },
            ["markdown"] = { prettier_formatter },
            ["markdown.mdx"] = { prettier_formatter },
            ["graphql"] = { prettier_formatter },
            ["handlebars"] = { prettier_formatter },
            ["templ"] = { "templ" },
        },
    },
}
