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

---@param ctx { filename: string }
---@return boolean
local function has_attached_oxlint_client(ctx)
    if not ctx.filename or ctx.filename == "" then
        return false
    end

    local bufnr = vim.fn.bufnr(ctx.filename)
    if bufnr < 1 then
        return false
    end

    return #vim.lsp.get_clients({ bufnr = bufnr, name = "oxlint" }) > 0
end

return {
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = function(_, opts)
            local lint = require("lint")

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
                condition = function(ctx)
                    return has_oxlint_config(ctx) and not has_attached_oxlint_client(ctx)
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "oxlint" then
                        vim.diagnostic.reset(lint.get_namespace("oxlint"), args.buf)
                    end
                end,
            })
        end,
    },
}
