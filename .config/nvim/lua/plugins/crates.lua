return {
    "saecki/crates.nvim",
    event = "VeryLazy",
    config = function()
        local crates = require("crates")
        local wk = require("which-key")

        wk.register({
            c = {
                c = {
                    name = "Crates actions",
                    t = {
                        crates.toggle,
                        "Toggle crates",
                    },
                    r = {
                        crates.reload,
                        "Reload",
                    },
                    v = {
                        crates.show_versions_popup,
                        "Versions popup",
                    },
                    f = {
                        crates.show_features_popup,
                        "Features popup",
                    },
                    d = {
                        crates.show_dependencies_popup,
                        "Dependencies popup",
                    },
                    u = {
                        crates.update_crate,
                        "Update crate",
                    },
                    a = {
                        crates.update_all_crates,
                        "Update all crates",
                    },
                    U = {
                        crates.upgrade_crate,
                        "Upgrade crate",
                    },
                    A = {
                        crates.upgrade_all_crates,
                        "Upgrade all crates",
                    },
                    e = {
                        crates.expand_plain_crate_to_inline_table,
                        "Expand crate to inline table",
                    },
                    E = {
                        crates.extract_crate_into_table,
                        "Extract crate into table",
                    },
                    H = {
                        crates.open_homepage,
                        "Open homepage",
                    },
                    R = {
                        crates.open_repository,
                        "Open repository",
                    },
                    D = {
                        crates.open_documentation,
                        "Open documentation",
                    },
                    C = {
                        crates.open_crates_io,
                        "Open crates.io",
                    },
                },
            },
        }, { prefix = "<leader>" })
        wk.register({
            c = {
                c = {
                    name = "Crates actions",
                    u = {
                        crates.update_crates,
                        "Update selected crates",
                    },
                    U = {
                        crates.upgrade_crates,
                        "Upgrade selected crates",
                    },
                },
            },
        }, { prefix = "<leader>", mode = "v" })
    end,
}
