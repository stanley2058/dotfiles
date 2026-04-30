local function normalize_path(path)
  if not path or path == "" then
    return nil
  end

  return vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
end

local function get_visual_selection()
  local mode = vim.fn.mode()
  if not mode:match("^[vV\22]$") then
    return vim.fn.expand("<cword>")
  end

  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]

  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  local lines = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
  return vim.trim(table.concat(lines, " "))
end

local function resolve_cwd(opts)
  opts = opts or {}

  if opts.cwd and opts.cwd ~= "" then
    return normalize_path(opts.cwd)
  end

  if opts.root == false then
    return normalize_path(vim.fn.getcwd())
  end
end

local function select_from_list(prompt, items, format_item, on_choice)
  if vim.tbl_isempty(items) then
    vim.notify(string.format("No %s available", prompt:lower()), vim.log.levels.INFO)
    return
  end

  vim.ui.select(items, {
    prompt = prompt,
    format_item = format_item,
  }, function(choice)
    if choice then
      on_choice(choice)
    end
  end)
end

local function edit_path(path)
  vim.cmd.edit(vim.fn.fnameescape(path))
end

local function run_fff_files(pick_opts)
  local fff = require("fff")
  local cwd = resolve_cwd(pick_opts)
  if cwd then
    return fff.find_files_in_dir(cwd)
  end
  return fff.find_files()
end

local function run_fff_grep(args)
  args = args or {}

  local fff = require("fff")
  local cwd = resolve_cwd(args.pick_opts)
  if cwd then
    fff.change_indexing_directory(cwd)
  end

  local grep_opts = vim.deepcopy(args.opts or {})
  if args.query and args.query ~= "" then
    grep_opts.query = args.query
  end

  return fff.live_grep(grep_opts)
end

local function buffer_label(buffer)
  local name = buffer.name ~= "" and vim.fn.fnamemodify(buffer.name, ":.") or "[No Name]"
  local modified = buffer.changed == 1 and " [+]" or ""
  local current = buffer.bufnr == vim.api.nvim_get_current_buf() and " (current)" or ""
  return string.format("%d: %s%s%s", buffer.bufnr, name, modified, current)
end

local function select_buffer(include_all)
  local buffers = vim.fn.getbufinfo(include_all and {} or { buflisted = 1 })

  table.sort(buffers, function(a, b)
    if a.lastused == b.lastused then
      return a.bufnr < b.bufnr
    end
    return a.lastused > b.lastused
  end)

  select_from_list("Buffers", buffers, buffer_label, function(choice)
    vim.api.nvim_set_current_buf(choice.bufnr)
  end)
end

local function in_directory(path, dir)
  if not dir or dir == "/" then
    return true
  end

  return path == dir or vim.startswith(path, dir .. "/")
end

local function select_oldfiles(cwd)
  local files = {}
  local seen = {}

  for _, file in ipairs(vim.v.oldfiles or {}) do
    local absolute = normalize_path(file)
    if absolute and vim.fn.filereadable(absolute) == 1 and not seen[absolute] and in_directory(absolute, cwd) then
      seen[absolute] = true
      files[#files + 1] = {
        path = absolute,
        label = vim.fn.fnamemodify(absolute, ":."),
      }
    end
  end

  select_from_list("Recent Files", files, function(item)
    return item.label
  end, function(choice)
    edit_path(choice.path)
  end)
end

local function unique_sorted(items)
  local ret = {}
  local seen = {}

  for _, item in ipairs(items) do
    if item ~= "" and not seen[item] then
      seen[item] = true
      ret[#ret + 1] = item
    end
  end

  table.sort(ret)
  return ret
end

local function select_command()
  local commands = unique_sorted(vim.fn.getcompletion("", "command"))
  select_from_list("Commands", commands, function(item)
    return item
  end, function(choice)
    local keys = vim.api.nvim_replace_termcodes(":" .. choice .. " ", true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end)
end

local function select_help()
  local help_tags = unique_sorted(vim.fn.getcompletion("", "help"))
  select_from_list("Help Tags", help_tags, function(item)
    return item
  end, function(choice)
    vim.cmd.help(choice)
  end)
end

local function select_colorscheme()
  local colorschemes = unique_sorted(vim.fn.getcompletion("", "color"))
  select_from_list("Colorschemes", colorschemes, function(item)
    return item
  end, function(choice)
    local ok, err = pcall(vim.cmd.colorscheme, choice)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end)
end

local function search_todos(keywords)
  run_fff_grep({
    query = table.concat(keywords, "|"),
    opts = {
      grep = {
        modes = { "regex" },
      },
    },
  })
end

local function show_notification_history()
  if pcall(vim.cmd, "Noice history") then
    return
  end

  vim.cmd.messages()
end

local function open_list(kind)
  local size = kind == "quickfix" and vim.fn.getqflist({ size = 0 }).size or vim.fn.getloclist(0, { size = 0 }).size

  if size == 0 then
    vim.notify(string.format("%s is empty", kind == "quickfix" and "Quickfix list" or "Location list"), vim.log.levels.INFO)
    return
  end

  vim.cmd(kind == "quickfix" and "copen" or "lopen")
end

return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    lazy = false,
    keys = {
      { "<leader>,", function() select_buffer(false) end, desc = "Switch Buffer" },
      { "<leader>/", function() run_fff_grep() end, desc = "Grep (Root Dir)" },
      { "<leader>:", function() vim.cmd("q:") end, desc = "Command History" },
      { "<leader><space>", function() run_fff_files() end, desc = "Find Files (Root Dir)" },
      { "<leader>n", show_notification_history, desc = "Notification History" },
      { "<leader>fb", function() select_buffer(false) end, desc = "Buffers" },
      { "<leader>fB", function() select_buffer(true) end, desc = "Buffers (all)" },
      { "<leader>fc", function() run_fff_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() run_fff_files() end, desc = "Find Files (Root Dir)" },
      { "<leader>fF", function() run_fff_files({ root = false }) end, desc = "Find Files (cwd)" },
      { "<leader>fr", function() select_oldfiles() end, desc = "Recent" },
      { "<leader>fR", function() select_oldfiles(normalize_path(vim.fn.getcwd())) end, desc = "Recent (cwd)" },
      { '<leader>s"', function() vim.cmd("registers") end, desc = "Registers" },
      { "<leader>s/", function() vim.cmd("q/") end, desc = "Search History" },
      { "<leader>sc", function() vim.cmd("q:") end, desc = "Command History" },
      { "<leader>sC", select_command, desc = "Commands" },
      { "<leader>sd", function() vim.cmd("Trouble diagnostics toggle") end, desc = "Diagnostics" },
      { "<leader>sD", function() vim.cmd("Trouble diagnostics toggle filter.buf=0") end, desc = "Buffer Diagnostics" },
      { "<leader>sg", function() run_fff_grep() end, desc = "Grep (Root Dir)" },
      { "<leader>sG", function() run_fff_grep({ pick_opts = { root = false } }) end, desc = "Grep (cwd)" },
      { "<leader>sh", select_help, desc = "Help Pages" },
      { "<leader>sl", function() open_list("loclist") end, desc = "Location List" },
      { "<leader>sq", function() open_list("quickfix") end, desc = "Quickfix List" },
      { "<leader>ss", function() vim.cmd("Trouble symbols toggle focus=false") end, desc = "Goto Symbol" },
      {
        "<leader>sS",
        function()
          vim.cmd("Trouble lsp toggle focus=false win.position=right")
        end,
        desc = "Goto Symbol (Workspace)",
      },
      { "<leader>st", function() search_todos({ "TODO", "FIX", "FIXME", "HACK", "BUG", "NOTE" }) end, desc = "Todo" },
      { "<leader>sT", function() search_todos({ "TODO", "FIX", "FIXME" }) end, desc = "Todo/Fix/Fixme" },
      {
        "<leader>sw",
        function()
          run_fff_grep({ query = get_visual_selection() })
        end,
        mode = { "n", "x" },
        desc = "Visual selection or word (Root Dir)",
      },
      {
        "<leader>sW",
        function()
          run_fff_grep({ pick_opts = { root = false }, query = get_visual_selection() })
        end,
        mode = { "n", "x" },
        desc = "Visual selection or word (cwd)",
      },
      { "<leader>uC", select_colorscheme, desc = "Colorscheme" },
    },
    opts = {
      prompt = "> ",
      title = "Find Files",
      lazy_sync = true,
      layout = {
        height = 0.9,
        width = 0.9,
        prompt_position = "top",
        preview_position = "right",
        preview_size = 0.55,
        flex = {
          size = 120,
          wrap = "top",
        },
        show_scrollbar = true,
        path_shorten_strategy = "middle",
      },
      preview = {
        enabled = true,
        line_numbers = true,
        cursorlineopt = "both",
        wrap_lines = false,
        filetypes = {
          markdown = { wrap_lines = true },
          text = { wrap_lines = true },
        },
      },
      keymaps = {
        close = "<Esc>",
        select = "<CR>",
        select_split = "<C-x>",
        select_vsplit = "<C-v>",
        select_tab = "<C-t>",
        move_up = { "<Up>", "<C-p>" },
        move_down = { "<Down>", "<C-n>" },
        preview_scroll_up = "<C-u>",
        preview_scroll_down = "<C-d>",
        cycle_grep_modes = "<C-r>",
        cycle_previous_query = "<C-o>",
        toggle_select = "<Tab>",
        send_to_quickfix = "<C-q>",
      },
      file_picker = {
        current_file_label = "(current)",
      },
      frecency = {
        enabled = true,
      },
      history = {
        enabled = true,
      },
      grep = {
        smart_case = true,
        modes = { "regex", "plain", "fuzzy" },
      },
    },
    config = function(_, opts)
      local fff = require("fff")
      fff.setup(opts)

      require("lazyvim.util.pick").picker = {
        name = "fff",
        commands = {
          files = "files",
          find_files = "files",
          oldfiles = "oldfiles",
          grep = "live_grep",
          live_grep = "live_grep",
          grep_cword = "grep_word",
          grep_string = "grep_word",
          grep_visual = "grep_word",
          grep_word = "grep_word",
          buffers = "buffers",
          colorscheme = "colorscheme",
          colorschemes = "colorscheme",
        },
        open = function(command, pick_opts)
          if command == "files" then
            return run_fff_files(pick_opts)
          end

          if command == "oldfiles" then
            return select_oldfiles(resolve_cwd(pick_opts))
          end

          if command == "live_grep" then
            return run_fff_grep({ pick_opts = pick_opts })
          end

          if command == "grep_word" then
            return run_fff_grep({ pick_opts = pick_opts, query = get_visual_selection() })
          end

          if command == "buffers" then
            return select_buffer(false)
          end

          if command == "colorscheme" then
            return select_colorscheme()
          end

          vim.notify(string.format("fff picker has no handler for '%s'", command), vim.log.levels.WARN)
        end,
      }
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = { enabled = false },
    },
    keys = {
      { "<leader>,", false },
      { "<leader>/", false },
      { "<leader>:", false },
      { "<leader><space>", false },
      { "<leader>n", false },
      { "<leader>fb", false },
      { "<leader>fB", false },
      { "<leader>fc", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fg", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
      { "<leader>fp", false },
      { "<leader>gd", false },
      { "<leader>gD", false },
      { "<leader>gs", false },
      { "<leader>gS", false },
      { "<leader>gi", false },
      { "<leader>gI", false },
      { "<leader>gp", false },
      { "<leader>gP", false },
      { "<leader>sb", false },
      { "<leader>sB", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sp", false },
      { "<leader>sw", false, mode = { "n", "x" } },
      { "<leader>sW", false, mode = { "n", "x" } },
      { '<leader>s"', false },
      { "<leader>s/", false },
      { "<leader>sa", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>si", false },
      { "<leader>sj", false },
      { "<leader>sk", false },
      { "<leader>sl", false },
      { "<leader>sM", false },
      { "<leader>sm", false },
      { "<leader>sR", false },
      { "<leader>sq", false },
      { "<leader>su", false },
      { "<leader>uC", false },
    },
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      { "<leader>st", false },
      { "<leader>sT", false },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
            { "gr", vim.lsp.buf.references, nowait = true, desc = "References" },
            { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
            { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
            { "gai", vim.lsp.buf.incoming_calls, desc = "Calls Incoming", has = "callHierarchy/incomingCalls" },
            { "gao", vim.lsp.buf.outgoing_calls, desc = "Calls Outgoing", has = "callHierarchy/outgoingCalls" },
            { "<leader>ss", function() vim.cmd("Trouble symbols toggle focus=false") end, desc = "Goto Symbol", has = "documentSymbol" },
            {
              "<leader>sS",
              function()
                vim.cmd("Trouble lsp toggle focus=false win.position=right")
              end,
              desc = "Goto Symbol (Workspace)",
              has = "workspace/symbols",
            },
          },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    enabled = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
}
