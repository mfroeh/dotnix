{ ... }: {
  programs.fzf = {
    enable = true;

    # https://github.com/sainnhe/tmux-fzf
    tmux.enableShellIntegration = true;
  };
}
