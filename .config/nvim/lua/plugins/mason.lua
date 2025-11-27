return {
    {
        "jay-babu/mason-null-ls.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                "sql_formatter",
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                "lua-language-server",
                "bash-language-server",
                "rust-analyzer",
                "gopls",
            },
        },
    },
}
