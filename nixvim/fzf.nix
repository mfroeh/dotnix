{ ... }:
{
  programs.nixvim = {
    plugins.fzf-lua = {
      enable = true;
      luaConfig.post = ''
        -- https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/profiles/max-perf.lua
        local fzf = require('fzf-lua')
        fzf.setup({
          "ivy",
            winopts = { preview = { default = "bat" } },
            manpages = { previewer = "man_native" },
            helptags = { previewer = "help_native" },
            lsp = { code_actions = { previewer = "codeaction_native" } },
            tags = { previewer = "bat" },
            btags = { previewer = "bat" },
          })
          fzf.register_ui_select()
      '';
    };
    keymaps = [
      # resume picker
      {
        mode = "n";
        key = "<leader>rr";
        action = "<cmd>FzfLua resume<cr>";
      }
      # files
      {
        mode = "n";
        key = "<c-p>";
        action = "<cmd>FzfLua files<cr>";
      }
      {
        mode = "n";
        key = "<leader>.";
        action = "<cmd>FzfLua files<cr>";
      }
      {
        mode = "n";
        key = "<leader>of";
        action = "<cmd>FzfLua files<cr>";
      }
      # buffers
      {
        mode = "n";
        key = "<c-,>";
        action = "<cmd>FzfLua buffers<cr>";
      }
      {
        mode = "n";
        key = "<leader>,";
        action = "<cmd>FzfLua buffers<cr>";
      }
      {
        mode = "n";
        key = "<leader>ob";
        action = "<cmd>FzfLua buffers<cr>";
      }
      # old files
      {
        mode = "n";
        key = "<leader>oo";
        action = "<cmd>FzfLua oldfiles<cr>";
      }
      # grep
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>FzfLua live_grep<cr>";
      }
      # files in directory
      {
        mode = "n";
        key = "<leader>od";
        action = ":lua require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') })<cr>";
      }
      # LSP
      {
        mode = "n";
        key = "gs";
        action = "<cmd>FzfLua lsp_document_symbols<cr>";
      }
      {
        mode = "n";
        key = "gS";
        action = "<cmd>FzfLua lsp_workspace_symbols<cr>";
      }
      {
        # lists all the places the symbol under the cursor is referenced
        key = "grr";
        mode = "n";
        action = "<cmd>FzfLua lsp_references<cr>";
      }
      {
        # lists all the implementations of the symbol: e.g. use on interface/trait/abstract class
        key = "gI";
        mode = "n";
        action = "<cmd>FzfLua lsp_implementations<cr>";
      }
      {
        mode = "n";
        key = "<leader>ld";
        action = "<cmd>FzfLua lsp_document_diagnostics<cr>";
      }
      {
        mode = "n";
        key = "<leader>lD";
        action = "<cmd>FzfLua lsp_workspace_diagnostics<cr>";
      }
      # zoxide
      {
        mode = "n";
        key = "<leader>jd";
        action = "<cmd>FzfLua zoxide<cr>";
        options.desc = "[j]ump [d]irectory";
      }
      # keybindings
      {
        mode = "n";
        key = "g?";
        action = "<cmd>FzfLua keymaps<cr>";
      }
    ];
  };
}
