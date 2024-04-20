return {
    "IMOKURI/line-number-interval.nvim",
    init = function()
        vim.cmd([[
            let g:line_number_interval_enable_at_startup = 1
            let g:line_number_interval = 5
            let g:line_number_interval#use_custom = 1

            highlight HighlightedLineNr guifg=#f5e0dc ctermfg=7
            highlight DimLineNr guifg=#6c7086 ctermfg=5

            let g:line_number_interval#custom_interval = [5,10,15,20,25,30,35,40,45]
            highlight HighlightedLineNr1 guifg=#e3fafc ctermfg=3
            highlight HighlightedLineNr2 guifg=#c5f6fa ctermfg=3
            highlight HighlightedLineNr3 guifg=#99e9f2 ctermfg=2
            highlight HighlightedLineNr4 guifg=#66d9e8 ctermfg=6
            highlight HighlightedLineNr5 guifg=#3bc9db ctermfg=4
            highlight HighlightedLineNr6 guifg=#22b8cf ctermfg=5
            highlight HighlightedLineNr7 guifg=#15aabf ctermfg=7
            highlight HighlightedLineNr8 guifg=#1098ad ctermfg=7
            highlight HighlightedLineNr9 guifg=#0c8599 ctermfg=7
        ]])
    end,
}
