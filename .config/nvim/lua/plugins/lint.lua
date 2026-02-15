local OXLINT_CONFIG_MARKERS = {
    ".oxlintrc.json",
    ".oxlintrc.jsonc",
    "oxlint.config.js",
    "oxlint.config.cjs",
    "oxlint.config.mjs",
    "oxlint.config.ts",
}

---@param ctx { filename: string }
---@return boolean
local function has_oxlint_config(ctx)
    if not ctx.filename or ctx.filename == "" then
        return false
    end

    local dir = vim.fs.dirname(ctx.filename)
    local root = vim.fs.root(dir, OXLINT_CONFIG_MARKERS)
    return root ~= nil
end

return {
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = function(_, opts)
            opts.linters_by_ft = opts.linters_by_ft or {}

            for _, ft in ipairs({
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
            }) do
                opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
                if not vim.tbl_contains(opts.linters_by_ft[ft], "oxlint") then
                    table.insert(opts.linters_by_ft[ft], 1, "oxlint")
                end
            end

            opts.linters = opts.linters or {}
            opts.linters.oxlint = vim.tbl_deep_extend("force", opts.linters.oxlint or {}, {
                condition = has_oxlint_config,
            })
        end,
    },
}
