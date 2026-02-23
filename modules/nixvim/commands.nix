{
  flake.nixvim.commands = {
    userCommands = {
      SO = {
        command = "source $MYVIMRC";
      };
    };

    autoCmd = [
      {
        desc = "highlight selection on yank";
        event = [ "TextYankPost" ];
        pattern = [ "*" ];
        callback.__raw = "function() vim.highlight.on_yank { timeout = 150 } end";
      }
      {
        desc = "open help in vertial split";
        event = [ "FileType" ];
        pattern = "help";
        command = "wincmd L";
      }
      {
        desc = "dont automatically insert comment charactes on 'o', 'O' adjacent to comment";
        event = [ "FileType" ];
        pattern = "*";
        command = "set formatoptions-=o";
      }
      {
        desc = "restore cursor position from shada";
        event = [ "BufReadPost" ];
        pattern = "*";
        callback.__raw = ''
          function(args)
            local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
            local row_count = vim.api.nvim_buf_line_count(args.buf)
            if mark[1] > 0 and mark[1] <= row_count then
              vim.api.nvim_win_set_cursor(0, mark)
              -- center after short delay
              vim.schedule(function() vim.cmd("normal! zz") end)
            end
          end
        '';
      }
      {
        desc = "enable list mode in visual mode";
        event = [ "ModeChanged" ];
        pattern = "*";
        callback = {
          __raw = "function() vim.opt_local.list = (vim.api.nvim_get_mode().mode:lower():match 'v' ~= nil) end";
        };
      }
      {
        desc = "quit if only remaining window is quickfix";
        event = [ "BufEnter" ];
        pattern = "*";
        callback.__raw = ''
          function()
            if vim.fn.winnr("$") == 1 and vim.bo.buftype == "quickfix" then
              vim.cmd("quit")
            end
          end'';
      }
    ];
  };
}
