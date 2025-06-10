local default_model = "google/gemini-2.5-flash-preview-05-20"
local current_model = default_model
local available_models = {
    "google/gemini-2.5-pro-preview",
    "google/gemini-2.5-flash-preview-05-20",
    "openai/gpt-4.1",
    "openai/o4-mini",
    "openai/o4-mini-high",
    "anthropic/claude-3.7-sonnet",
    "anthropic/claude-3.5-sonnet",
    "anthropic/claude-sonnet-4",
    "anthropic/claude-opus-4",
}
local function select_model()
    vim.ui.select(available_models, {
        prompt = "Select Model (" .. current_model .. ")",
    }, function(choice)
        if choice then
            current_model = choice
            vim.notify("Selected model: " .. current_model)
        end
    end)
end

return {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>Cc", "<cmd>CodeCompanion<cr>", desc = "Code Companion", mode = { "n" } },
        { "<leader>Cc", ":CodeCompanion<cr>", desc = "Code Companion", mode = { "v" } },
        { "<leader>Ca", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "n" } },
        { "<leader>Ca", ":CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "v" } },
        { "<leader>Ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion Chat Toggle", mode = { "n" } },
        { "<leader>Ct", ":CodeCompanionChat Toggle<cr>", desc = "Code Companion Chat Toggle", mode = { "v" } },
        { "<leader>Cm", select_model, desc = "Select Model", mode = { "n" } },
        { "<leader>Cn", ":CodeCompanionChat Add<cr>", desc = "Code Companion Chat Add", mode = { "v" } },
    },

    opts = {
        strategies = {
            chat = {
                adapter = "openrouter",
                keymaps = {
                    submit = {
                        modes = { n = "<CR>" },
                        description = "Submit",
                        callback = function(chat)
                            chat:apply_model(current_model)
                            chat:submit()
                        end,
                    },
                },
            },
            inline = {
                adapter = "openrouter",
            },
            cmd = {
                adapter = "openrouter",
            },
        },
        adapters = {
            openrouter = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        url = "https://openrouter.ai/api",
                        api_key = os.getenv("OPENROUTER_API_KEY"),
                        chat_url = "/v1/chat/completions",
                    },
                    schema = {
                        model = {
                            default = current_model,
                        },
                    },
                })
            end,
        },
    },
}
