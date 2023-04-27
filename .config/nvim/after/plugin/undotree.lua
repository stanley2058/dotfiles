vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

if vim.fn.has("persistent_undo") == 1 then
    local target_path = vim.fn.expand('~/.cache/nvim/undo')

    -- create the directory and any parent directories
    -- if the location does not exist.
    if vim.fn.isdirectory(target_path) ~= 1 then
        vim.fn.mkdir(target_path, "p", 0755)
    end

    vim.o.undodir = target_path
    vim.o.undofile = true
end
