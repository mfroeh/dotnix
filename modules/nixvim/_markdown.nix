{
  plugins.render-markdown.enable = true;
  plugins.lsp.servers.marksman = {
    enable = true;
  };

  extraConfigLuaPost = ''
    function CreateNote(path)
        local datetime = os.date("%Y-%m-%d %H:%M:%S")
        vim.cmd("edit " .. path)

      local stat = vim.uv.fs_stat(path)
      if not stat or stat.size == 0 then
          vim.api.nvim_buf_set_lines(0, 0, -1, false, { datetime, "", "" })
          vim.api.nvim_win_set_cursor(0, {3, 0})
          vim.cmd("startinsert")
      else
          vim.cmd("normal! G")
      end
    end
  '';

  keymaps = [
    {
      mode = [
        "n"
      ];
      key = "<leader>jn";
      action.__raw = ''
        function()
          local today = os.date("%Y-%m-%d")
          local path = vim.fn.expand("~/Journal/" .. today .. ".md")
          CreateNote(path)
        end
      '';
    }
    {
      mode = [
        "n"
      ];
      key = "<leader>bd";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = 'Name: ' }, function(input)
              if input then 
                local path = vim.fn.expand("~/Notes/" .. input .. ".md")
                CreateNote(path)
              end
          end)
        end
      '';
    }
  ];
}
