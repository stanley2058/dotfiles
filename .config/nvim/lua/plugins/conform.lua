---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
    local conform = require("conform")
    for i = 1, select("#", ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then
            return formatter
        end
    end
    return select(1, ...)
end

local function prettier_formatter(bufnr)
    return { first(bufnr, "prettierd", "prettier") }
end

local function eslint_formatter(bufnr)
    return { first(bufnr, "eslint_d", "eslint") }
end

local function javascript_formatter(bufnr)
    local formatters = {}
    vim.list_extend(formatters, prettier_formatter(bufnr))
    vim.list_extend(formatters, eslint_formatter(bufnr))
    return formatters
end

return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            timeout_ms = 5000,
        },
        formatters = {
            eslint_d = {
                timeout_ms = 10000,
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
            ["javascript"] = javascript_formatter,
            ["javascriptreact"] = javascript_formatter,
            ["typescript"] = javascript_formatter,
            ["typescriptreact"] = javascript_formatter,
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
