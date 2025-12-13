{ ... }:
{
  programs.nixvim = {
    plugins.lazygit.enable = true;
    plugins.gitsigns.enable = true;
    plugins.gitsigns.settings.current_line_blame = true;

    keymaps = [
      {
        mode = "n";
        key = "gm";
        action = "<cmd>LazyGit<cr>";
      }
      {
        mode = "n";
        key = "[c";
        action = "<cmd>Gitsigns nav_hunk prev<cr>";
      }
      {
        mode = "n";
        key = "]c";
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
    ];
  };
}
