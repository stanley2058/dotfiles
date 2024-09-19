local lsp_server_config = {}

-- Get the filenames and require them
for _, path in ipairs(vim.split(vim.fn.glob("~/.config/nvim/lua/plugins/lsp-config/*.lua"), "\n")) do
    local path_split = vim.fn.split(path, "/") --path is a string path_split is a table
    local file = string.gsub(path_split[#path_split], "%.lua?$", "") -- trim off .lua\n
    if file ~= "init" then
        lsp_server_config[file] = require("plugins.lsp-config." .. file)
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = {
                enabled = false,
            },
            servers = lsp_server_config,
            setup = {
                rust_analyzer = function()
                    return true
                end,

                tailwindcss = function(_, opts)
                    opts.settings = {
                        tailwindCSS = {
                            experimental = {
                                classRegex = {
                                    { "cm\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
                                    { "(?:twMerge|twJoin)\\(([^;]*)[\\);]", "[`'\"`]([^'\"`;]*)[`'\"`]" },
                                },
                            },
                        },
                    }
                end,
            },
        },
    },
}
