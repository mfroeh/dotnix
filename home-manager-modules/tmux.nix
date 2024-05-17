{ config, pkgs, lib, ... }:
let
  base16-theme = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-base16-theme";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "jatap";
      repo = "tmux-base16-statusline";
      rev = "5dc655dfcfa3fcb574c28fb2b8c57bdd29b178cf";
      sha256 = "sha256-Z3JEQZegpyeyKz1uazDCCF50rc/QqW2LCrMRFo+SQIg=";
    };
  };
in
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
      tmux-fzf # prefix + C-f 
      gruvbox # theme
      prefix-highlight # indicate if prefix pressed
    ];

    extraConfig = ''
      # vi like pane creation
      bind v split-window -h
      bind s split-window -v
      bind o kill-pane -a

      # new windows default to the current windows dir
      bind c new-window -c "#{pane_current_path}"

      TMUX_FZF_LAUNCH_KEY="C-f"

      # put window status in centre
      set -g status-justify centre
    '';

  };
}
