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
        key = "<leader>,";
        action = "<cmd>FzfLua buffers<cr>";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>FzfLua live_grep<cr>";
      }
      {
        mode = "n";
        key = "<leader>?";
        action = "<cmd>FzfLua oldfiles<cr>";
      }
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
        mode = "n";
        key = "<leader>ld";
        action = "<cmd>FzfLua lsp_document_symbols<cr>";
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
    ];
  };
}
