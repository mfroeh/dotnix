{ ... }:
{
  programs.nixvim = {
    plugins.fzf-lua = {
      enable = true;
      luaConfig.post = ''require("fzf-lua").setup({"ivy"})'';
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
        key = "<leader>lo";
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
