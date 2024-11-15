{ pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "glsl" ];
    package = pkgs.zed-editor.fhs;
    userSettings = {
      theme = {
        mode = "system";
        dark = "Atelier Sulphurpool Dark";
        light = "Atelier Sulphurpool Light";
      };

      features = { inline_completion_provider = "copilot"; };

      # waiting on https://github.com/pop-os/cosmic-text/pull/296
      # buffer_font_family = "Hack Nerd Font Mono";
      buffer_font_size = 14;
      buffer_font_weight = 400;

      pane_split_direction_horizontal = "down";
      pane_split_direction_vertical = "right";

      # Show method signatures in the editor, when inside parentheses.
      auto_signature_help = false;

      cursor_blink = false;
      relative_line_numbers = true;
      scrollbar = { show = "auto"; };
      scroll_beyond_last_line = "off";
      soft_wrap = "editor_width";

      git = {
        git_gutter = "hide"; # this is already displayed in the scrollbar
      };

      tabs = {
        git_status = true;
        file_icons = true;
      };

      # https://zed.dev/docs/vim
      vim_mode = true;
      vim = {
        use_system_clipboard = "always";
        # absolute line numbers in insert mode, relative outside
        toggle_relative_line_numbers = true;
      };

      terminal = { cursor_shape = "bar"; };
    };
    userKeymaps = [
      {
        context = "VimControl && !menu";
        # any key bindings that should work in normal and visual mode
        bindings = { };
      }
      {
        # any key bindings that should work in normal mode
        context = "vim_mode == normal && !menu";
        bindings = { "shift-y" = [ "workspace::SendKeystrokes" "y" "$" ]; };
      }
      {
        # any key bindings that should work in insert mode
        context = "vim_mode == insert";
        bindings = { };
      }
    ];
  };

  home.packages = with pkgs;
    [ nixd nixfmt ] ++ [ (nerdfonts.override { fonts = [ "Hack" ]; }) ];
}
