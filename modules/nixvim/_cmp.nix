{ self, ... }:
{

  plugins.blink-cmp = {
    enable = true;
    setupLspCapabilities = true;
    settings = {
      keymap = {
        preset = "none";
        "<c-space>" = [
          "show"
          "show_documentation"
          "hide_documentation"
        ];
        "<c-e>" = [
          "hide"
          "fallback"
        ];
        "<Tab>" = [
          {
            __raw = ''
              function(cmp)
                if cmp.snippet_active() then 
                  return cmp.accept()
                else 
                  return cmp.select_and_accept() 
                end
              end
            '';
          }
          "snippet_forward"
          "fallback"
        ];
        "<c-f>" = [
          "select_and_accept"
          "fallback"
        ];
        "<S-Tab>" = [
          "snippet_backward"
          "fallback"
        ];
        "<Up>" = [
          "select_prev"
          "fallback"
        ];
        "<Down>" = [
          "select_next"
          "fallback"
        ];
        "<c-p>" = [
          "select_prev"
          "fallback"
        ];
        "<c-k>" = [
          "select_prev"
          "fallback"
        ];
        "<c-n>" = [
          "select_next"
          "fallback"
        ];
        "<c-j>" = [
          "select_next"
          "fallback"
        ];
        "<c-u>" = [
          "scroll_documentation_up"
          "fallback"
        ];
        "<c-d>" = [
          "scroll_documentation_down"
          "fallback"
        ];
        "<c-s>" = [
          "show_signature"
          "hide_signature"
          "fallback"
        ];
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
            preselect.__raw = ''
              function(ctx)
                return not require('blink.cmp').snippet_active({ direction = 1 })
              end
            '';
            auto_insert = false;
          };
        };
        menu = {
          enabled = true;
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
        prebuilt_binaries.download = true;
      };
      signature = {
        enabled = true;
      };
      sources.default = [
        "lsp"
        "path"
        "snippets"
        "buffer"
      ];
    };
  };

  # todo: switch snippet setup
  plugins.friendly-snippets.enable = true;

  xdg.configFile."nvim/snippets" = {
    source = "${self}/config/snippets";
    recursive = true;
  };
}
