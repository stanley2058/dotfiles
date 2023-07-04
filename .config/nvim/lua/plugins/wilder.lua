return {
    {
        "folke/noice.nvim",
        opts = {
            cmdline = {
                view = "cmdline",
            },
        },
    },
    {
        "gelguy/wilder.nvim",
        init = function()
            local wilder = require("wilder")

            local gradient = {
                "#F9E2AF",
                "#F5DDB6",
                "#F1D7BC",
                "#ECD2C3",
                "#E8CCC9",
                "#E4C7D0",
                "#E0C1D6",
                "#DCBCDD",
                "#D8B6E3",
                "#D3B1EA",
                "#CFABF0",
                "#CBA6F7",
            }

            for i, fg in ipairs(gradient) do
                gradient[i] = wilder.make_hl(
                    "WilderGradient" .. i,
                    "Pmenu",
                    { { a = 1 }, { a = 1 }, { foreground = fg, background = "#1e1e2e" } }
                )
            end

            wilder.setup({
                modes = { ":", "/", "?" },
            })
            wilder.set_option("pipeline", {
                wilder.branch(wilder.cmdline_pipeline(), wilder.search_pipeline()),
            })

            wilder.set_option(
                "renderer",
                wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                    pumblend = 20,
                    highlighter = wilder.highlighter_with_gradient({
                        wilder.basic_highlighter(),
                    }),
                    left = { " ", wilder.popupmenu_devicons() },
                    right = { " ", wilder.popupmenu_scrollbar() },
                    highlights = {
                        default = wilder.make_hl("Catppuccin", "Pmenu", {
                            { a = 1 },
                            { a = 1 },
                            { foreground = "#cdd6f4", background = "#1e1e2e" },
                        }),
                        gradient = gradient,
                        border = "Normal",
                    },
                    border = "rounded",
                }))
            )
        end,
    },
}
