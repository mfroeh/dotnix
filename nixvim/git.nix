{ ... }:
{
  programs.nixvim = {
    plugins.lazygit.enable = true;
    plugins.gitsigns.enable = true;
    plugins.gitsigns.settings.current_line_blame = true;
    plugins.gitsigns.luaConfig.post = ''
      require('gitsigns').setup({
        -- always diff against HEAD, such that staged hunks are included in the diff (and available via [c and ]c)
        base = "HEAD"
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "gm";
        action = "<cmd>LazyGit<cr>";
      }
      {
        mode = "n";
        key = "[h";
        action = "<cmd>Gitsigns nav_hunk prev<cr>";
      }
      {
        mode = "n";
        key = "]h";
        action = "<cmd>Gitsigns nav_hunk next<cr>";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action.__raw = ''
          function() 
            for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid))
              if vim.startswith(bufname, "gitsigns-blame") then
                vim.api.nvim_win_close(winid, true)
                return
              end
            end

            vim.cmd('Gitsigns blame')
          end
        '';
      }
      {
        mode = "n";
        key = "<leader>gh";
        action = "<cmd>FzfLua git_hunks<cr>";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>FzfLua git_diff<cr>";
      }
      {
        mode = "n";
        key = "ghd";
        action = "<cmd>Gitsigns reset_hunk<cr>";
      }
    ];
  };
}
