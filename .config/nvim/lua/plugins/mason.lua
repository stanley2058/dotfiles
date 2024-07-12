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
        "williamboman/mason.nvim",
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
