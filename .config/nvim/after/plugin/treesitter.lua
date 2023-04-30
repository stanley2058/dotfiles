require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = { "vimdoc", "c", "lua", "rust", "go", "vim", "javascript", "typescript", "java", "fish", "awk" },

	-- Install parsers synchornously (only applied to `ensure_installed`)
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})
