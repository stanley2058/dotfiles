return {
    {
        "jay-babu/mason-null-ls.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                "prettierd",
                "eslint_d",
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
                "prettierd",
                "lua-language-server",
                "bash-language-server",
                "rust-analyzer",
                "gopls",
            },
        },
    },
}
