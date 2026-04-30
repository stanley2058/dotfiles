---@param bufnr integer
---@param ... string
---@return string[]
local function available(bufnr, ...)
    local conform = require("conform")
    local formatters = {}

    for i = 1, select("#", ...) do
        local formatter = select(i, ...)
        local ok, info = pcall(conform.get_formatter_info, formatter, bufnr)
        if ok and info.available then
            table.insert(formatters, formatter)
        end
    end

    return formatters
end

local function prettier_formatter(bufnr)
    return available(bufnr, "prettierd", "prettier")
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

local OXLINT_CONFIG_MARKERS = {
    "oxlintrc.json",
    "oxlintrc.jsonc",
    ".oxlintrc.json",
    ".oxlintrc.jsonc",
    "oxlint.config.js",
    "oxlint.config.cjs",
    "oxlint.config.mjs",
    "oxlint.config.ts",
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

---@param path string
---@return boolean
local function is_dir(path)
    local stat = vim.uv.fs_stat(path)
    return stat ~= nil and stat.type == "directory"
end

---@param path string
---@param text string
---@return boolean
local function file_contains(path, text)
    local fd = io.open(path, "r")
    if not fd then
        return false
    end

    local content = fd:read("*a")
    fd:close()
    return content ~= nil and content:find(text, 1, true) ~= nil
end

---@param bufnr integer
---@return boolean
local function prettier_is_usable(bufnr)
    local root = find_root(bufnr, PRETTIER_CONFIG_MARKERS)
    if root == nil then
        return false
    end

    for _, marker in ipairs(PRETTIER_CONFIG_MARKERS) do
        local config_path = vim.fs.joinpath(root, marker)
        if file_contains(config_path, "prettier-plugin-tailwindcss") then
            return is_dir(vim.fs.joinpath(root, "node_modules", "prettier-plugin-tailwindcss"))
        end
    end

    return true
end

---@param bufnr integer
---@return string[]
local function prettier_or_oxfmt(bufnr)
    if prettier_is_usable(bufnr) then
        local prettier = prettier_formatter(bufnr)
        if #prettier > 0 then
            return prettier
        end
    end

    return available(bufnr, "oxfmt")
end

local function javascript_formatter(bufnr)
    return available(bufnr, "oxfmt", "oxlint")
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

    return prettier_or_oxfmt(bufnr)
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
                command = require("conform.util").from_node_modules("oxfmt"),
                stdin = true,
                args = { "--stdin-filepath", "$FILENAME" },
                cwd = require("conform.util").root_file({
                    ".oxfmtrc.json",
                    "package.json",
                    ".git",
                }),
                require_cwd = true,
            },
            oxlint = {
                timeout_ms = 10000,
                command = require("conform.util").from_node_modules("oxlint"),
                stdin = false,
                args = { "--fix", "$FILENAME" },
                cwd = require("conform.util").root_file(OXLINT_CONFIG_MARKERS),
                require_cwd = true,
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
            vue = js_like_with_biome,
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
