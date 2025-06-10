return {
    "Saecki/crates.nvim",
    config = function()
        local crates = require("crates")
        local wk = require("which-key")

        wk.add({
            {
                mode = { "n" },
                { "<leader>cc", group = "Crates actions" },
                { "<leader>cct", crates.toggle, desc = "Toggle crates" },
                { "<leader>ccr", crates.reload, desc = "Reload" },
                { "<leader>ccv", crates.show_versions_popup, desc = "Versions popup" },
                { "<leader>ccf", crates.show_features_popup, desc = "Features popup" },
                { "<leader>ccd", crates.show_dependencies_popup, desc = "Dependencies popup" },
                { "<leader>ccu", crates.update_crate, desc = "Update crate" },
                { "<leader>cca", crates.update_all_crates, desc = "Update all crates" },
                { "<leader>ccU", crates.upgrade_crate, desc = "Upgrade crate" },
                { "<leader>ccA", crates.upgrade_all_crates, desc = "Upgrade all crates" },
                { "<leader>cce", crates.expand_plain_crate_to_inline_table, desc = "Expand crate to inline table" },
                { "<leader>ccE", crates.extract_crate_into_table, desc = "Extract crate into table" },
                { "<leader>ccH", crates.open_homepage, desc = "Open homepage" },
                { "<leader>ccR", crates.open_repository, desc = "Open repository" },
                { "<leader>ccD", crates.open_documentation, desc = "Open documentation" },
                { "<leader>ccC", crates.open_crates_io, desc = "Open crates.io" },
            },
            {
                mode = { "v" },
                { "<leader>cc", group = "Crates actions" },
                { "<leader>ccu", crates.update_crates, desc = "Update selected crates" },
                { "<leader>ccU", crates.upgrade_crates, desc = "Upgrade selected crates" },
            },
        })
    end,
}
