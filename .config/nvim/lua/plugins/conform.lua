local prettier_formatter = { "prettierd", "prettier" }
local eslint_formatter = { "eslint_d", "eslint" }
local combined_formatter = {}

vim.list_extend(combined_formatter, prettier_formatter)
vim.list_extend(combined_formatter, eslint_formatter)

return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            timeout_ms = 5000,
        },
        formatters = {
            eslint_d = {
                async = true,
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
            ["javascript"] = combined_formatter,
            ["javascriptreact"] = combined_formatter,
            ["typescript"] = combined_formatter,
            ["typescriptreact"] = combined_formatter,
            ["vue"] = prettier_formatter,
            ["css"] = prettier_formatter,
            ["scss"] = prettier_formatter,
            ["less"] = prettier_formatter,
            ["html"] = prettier_formatter,
            ["json"] = prettier_formatter,
            ["jsonc"] = prettier_formatter,
            ["yaml"] = prettier_formatter,
            ["markdown"] = prettier_formatter,
            ["markdown.mdx"] = prettier_formatter,
            ["graphql"] = prettier_formatter,
            ["handlebars"] = prettier_formatter,
            ["templ"] = { "templ" },
        },
    },
}
