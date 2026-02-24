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

local PRETTIER_CONFIG_MARKERS = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.json5",
    ".prettierrc.yaml",
    ".prettierrc.yml",
    ".prettierrc.toml",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.mjs",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
    "prettier.config.ts",
}

---@param bufnr integer
---@param markers string[]
---@return string|nil
local function find_root(bufnr, markers)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname == "" then
        return nil
    end
    local dir = vim.fs.dirname(bufname)
    return vim.fs.root(dir, markers)
end

---@param bufnr integer
---@return boolean
local function has_biome(bufnr)
    local root = find_root(bufnr, { "biome.json", "biome.jsonc" })
    return root ~= nil
end

---@param bufnr integer
---@return boolean
local function has_prettier_config(bufnr)
    local root = find_root(bufnr, PRETTIER_CONFIG_MARKERS)
    return root ~= nil
end

local function javascript_formatter(bufnr)
    local formatters = {}

    if has_prettier_config(bufnr) then
        vim.list_extend(formatters, prettier_formatter(bufnr))
    else
        vim.list_extend(formatters, { "oxfmt" })
    end

    vim.list_extend(formatters, eslint_formatter(bufnr))
    return formatters
end

local function js_like_with_biome(bufnr)
    if has_biome(bufnr) then
        return { "biome-check" }
    end
    return javascript_formatter(bufnr)
end

local function simple_with_biome(bufnr)
    if has_biome(bufnr) then
        return { "biome-check" }
    end

    if has_prettier_config(bufnr) then
        return prettier_formatter(bufnr)
    end

    return { "oxfmt" }
end

return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            timeout_ms = 5000,
        },
        formatters = {
            ["biome-check"] = {
                timeout_ms = 8000,
                require_cwd = true,
                cwd = require("conform.util").root_file({
                    "biome.json",
                    "biome.jsonc",
                    "package.json",
                    ".git",
                }),
            },
            oxfmt = {
                timeout_ms = 8000,
                command = "oxfmt",
                stdin = true,
                args = { "--line-width=80", "--stdin-filepath", "$FILENAME" },
            },
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
            javascript = js_like_with_biome,
            javascriptreact = js_like_with_biome,
            typescript = js_like_with_biome,
            typescriptreact = js_like_with_biome,
            vue = simple_with_biome,
            css = simple_with_biome,
            scss = simple_with_biome,
            less = simple_with_biome,
            html = simple_with_biome,
            json = simple_with_biome,
            jsonc = simple_with_biome,
            yaml = simple_with_biome,
            markdown = simple_with_biome,
            ["markdown.mdx"] = simple_with_biome,
            graphql = simple_with_biome,
            handlebars = simple_with_biome,
            templ = { "templ" },
        },
    },
}
