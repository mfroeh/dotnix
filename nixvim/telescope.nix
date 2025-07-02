{ ... }:
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
      };
      settings = {
        defaults = {
          mappings = {
            i = {
              "<C-j>" = "move_selection_next";
              "<C-k>" = "move_selection_previous";
              "<C-u>" = false;
              "<esc>" = "close";
            };
          };
        };
      };
      keymaps = {
        "<c-j>" = {
          action = "actions.move_selection_next";
        };
        "<c-k>" = {
          action = "actions.move_selection_previous";
        };
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
