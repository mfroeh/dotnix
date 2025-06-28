{ ... }:
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
      };
      keymaps = {
        "gr" = {
          action = "live_grep";
        };
        "<c-;>" = {
          action = "git_files";
        };
        "gb" = {
          action = "buffers";
        };
        "gs" = {
          action = "lsp_document_symbols";
        };
        "gS" = {
          action = "lsp_workspace_symbols";
        };
      };
    };
  };
}
