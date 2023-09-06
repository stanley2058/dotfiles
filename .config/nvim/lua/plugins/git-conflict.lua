return {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    version = "*",
    opts = {
        default_mappings = {
            ours = "ck",
            theirs = "cj",
            none = "cd",
            both = "ca",
            next = "cn",
            prev = "cp",
        },
    },
}
