{ self, ... }:
{
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "none";
          "<c-f>" = [
            "select_and_accept"
          ];
          "<right>" = [
            "select_and_accept"
          ];
          "<c-j>" = [
            "select_next"
            "fallback"
          ];
          "<c-n>" = [
            "select_next"
            "fallback"
          ];
          "<down>" = [
            "select_next"
            "fallback"
          ];
          "<c-k>" = [
            "select_prev"
            "fallback"
          ];
          "<up>" = [
            "select_prev"
            "fallback"
          ];
          "<c-p>" = [
            "select_prev"
            "fallback"
          ];
          "<c-u>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<PageUp>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-d>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<PaguDown>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<c-space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<S-Tab>" = [
            "snippet_backward"
            "fallback"
          ];
          "<Tab>" = [
            "snippet_forward"
            "fallback"
          ];
        };
        # todo: doesn't seem to work
        cmdline = {
          enabled = true;
        };
        completion = {
          keyword = {
            # foo_|_bar (| denotes the cursor), if `prefix` is chosen, we only match on foo_, if `full` is given, the full word is used
            range = "prefix";
          };
          accept = {
            auto_brackets = {
              enabled = true;
            };
          };
          list = {
            selection = {
              preselect = true;
              auto_insert = false;
            };
          };
          menu = {
            auto_show = true;
          };
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 50;
            # disable if performance issues
            treesitter_highlighting = true;
          };
          ghost_text = {
            enabled = true;
          };
        };
        fuzzy = {
          implementation = "rust";
        };
        signature = {
          # we show this through lsp-signature, it works way better
          enabled = false;
        };
      };
    };

    plugins.friendly-snippets.enable = true;

  };

  xdg.configFile."nvim/snippets" = {
    source = "${self}/config/snippets";
    recursive = true;
  };
}
