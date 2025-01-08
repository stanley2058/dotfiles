return {
    {
        "saghen/blink.cmp",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ["<C-.>"] = { "show", "show_documentation", "hide_documentation" },
                ["<M-.>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-a>"] = { "select_and_accept" },
            },
        },
    },
}
