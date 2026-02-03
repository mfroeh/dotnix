{
  # https://github.com/chentoast/marks.nvim/
  plugins.marks = {
    enable = true;
    settings = {
      default_mappings = true;
      builtin_marks = [
        "." # position of the last change (e.g. insert, change, delete)
        "^" # position where we last exited insert mode, use gi to jump there and begin inserting
        "'"
        "\""
        "["
        "]"
        "<"
        ">"
      ];
    };
  };

  autoCmd = [
    {
      desc = "set I mark when existing insert mode";
      event = [ "InsertLeave" ];
      pattern = [ "*" ];
      callback.__raw = ''
        function()
          local pos = vim.api.nvim_win_get_cursor(0)
          local col = math.min(pos[2]+1, #vim.fn.getline(pos[1]))
          vim.api.nvim_buf_set_mark(0, "I", pos[1], col, {})
          vim.api.nvim_buf_set_mark(0, "i", pos[1], col, {})
        end
      '';
    }
  ];

  keymaps = [
    # map ' to ` since the default behavior of ` is more useful
    {
      key = "'";
      mode = [
        "n"
        "v"
      ];
      action.__raw = ''
        function()
          pcall(function() require('treesitter-context').disable() end)
          JumpToMark(true)
          pcall(function() require('treesitter-context').enable() end)
        end
      '';
      options.silent = true;
    }
    {
      key = "`";
      mode = [
        "n"
        "v"
      ];
      action.__raw = ''
        function()
          pcall(function() require('treesitter-context').disable() end)
          JumpToMark(false)
          pcall(function() require('treesitter-context').enable() end)
        end
      '';
      options.silent = true;
    }
    {
      key = "gI";
      mode = "n";
      action = "`Ii";
    }
  ];

  extraConfigLuaPost = ''
    local ns = vim.api.nvim_create_namespace('mark-radar')
    vim.api.nvim_command(
      'highlight default RadarMark guifg=#ff007c gui=bold ctermfg=198 cterm=bold'
    )
    vim.api.nvim_command(
      'highlight default RadarBackground guifg=#666666 ctermfg=242'
    )

    local function highlight_marks(mark_list, top_line, bottom_line, jump_to_column)
      local buffer_file = vim.fn.expand("%:p")
      for _, mark in ipairs(mark_list) do
        if mark.file ~= nil and vim.fn.fnamemodify(mark.file, ':p') ~= buffer_file then
          goto continue
        end

        -- get mark position information
        local line, col = mark.pos[2], mark.pos[3] - 1

        -- filter out invalid marks
        local line_count = vim.api.nvim_buf_line_count(0)
        if line < 1 or line > line_count or col < 0 or col > #vim.fn.getline(line) then
          goto continue
        end

        -- indent column if necessary
        if not jump_to_column then
          col = vim.fn.indent(vim.fn.line(mark.mark))
        end

        -- adjust positions of off-screen marks to be barely on the screen
        if line < top_line then
          line = top_line
          col = 0
        elseif line > bottom_line then
          line = bottom_line
          col = 0
        end

        -- draw marks
        vim.api.nvim_buf_set_extmark(0, ns, line-1, col, {
          virt_text = { { mark.mark:sub(2), "RadarMark" } },
          virt_text_pos = "inline",
          priority = 200,
        })
        ::continue::
      end

      vim.cmd('redraw')
    end

    local function clean_up(top_line, bottom_line)
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    end

    function JumpToMark(jump_to_column)
      local win_info = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
      local top_line, bottom_line = win_info.topline, win_info.botline
      local bottom_line_column_count = string.len(
        vim.api.nvim_buf_get_lines(0, bottom_line - 1, bottom_line, false)[1]
      )

      local mark_list = {}
      table.foreach(vim.fn.getmarklist(), function(_, v) if string.match(v.mark, "%u") ~= nil then table.insert(mark_list, v) end end)
      table.foreach(vim.fn.getmarklist(vim.fn.bufnr('%')), function(_, v) table.insert(mark_list, v) end)

      vim.highlight.range(
        0,
        ns,
        "RadarBackground",
        { top_line - 1, 0 },
        { bottom_line, bottom_line_column_count },
        'V',
        false
      )

      highlight_marks(mark_list, top_line, bottom_line, jump_to_column)

      while true do
        local ok, key = pcall(vim.fn.getchar)
        if not ok then
          clean_up(top_line, bottom_line)
          break
        end

        if type(key) == 'number' then
          local mark = vim.fn.nr2char(key)
          local cmd = string.format("normal! %s" .. mark, jump_to_column and "`" or "'")
          local succ, err_msg = pcall(function() vim.cmd(cmd) end)
          if not succ then
            print(err_msg)
          else
            vim.cmd("normal! zz")
          end
          break
        end
      end

      clean_up(top_line, bottom_line)
    end
  '';
}
