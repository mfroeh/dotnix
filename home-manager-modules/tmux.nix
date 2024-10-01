{ config, pkgs, lib, inputs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";

    prefix = "C-a";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    # https://github.com/microsoft/vscode/issues/207545
    escapeTime = 50;
    newSession = true;
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      prefix-highlight # indicate if prefix pressed (prefix_highlight)
      { plugin = cpu;
        extraConfig = ''
          set -g status-right '#[bg=default,fg=default]GPU: #{gpu_percentage} CPU: #{cpu_percentage} | %H:%M %a %d'
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
        set -g @resurrect-strategy-vim 'session' # restore from `Session.vim` file
        set -g @resurrect-strategy-nvim 'session' # restore from `Session.vim` file
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
        set -g @continuum-restore 'on' # restore last saved environment when tmux is started
        set -g @continuum-save-interval '15' # in minutes
        '';
      }
      yank
      open
      {
        plugin = tmux-fzf;
        extraConfig = "TMUX_FZF_LAUNCH_KEY='C-f'";
      }
    ];

    extraConfig = ''
      # vi like pane creation
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"
      bind o kill-pane -a

      # new windows default to the current windows dir
      bind c new-window -c "#{pane_current_path}"
      
      set-option -s status-interval 1

      # theme
      # Set the status bar position and style
      set-option -g status-position 'bottom'
      set-option -g status-justify 'centre'
      set-option -g status-left-length 35
      set-option -g status-right-length 35

      set -g status-bg 'blue'  # Background color for the status bar
      set -g status-fg 'white'  # Foreground color for the status bar

      # Left side status bar
      set-option -g status-left "#[bg=default,fg=default]#{?client_prefix,λ, }"

      # Window status formatting
      set-option -g window-status-format " #I:#W "
      set-option -g window-status-current-format "#[bg=orange,fg=default] #I:#W "
    '';
  };
}
