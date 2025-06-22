{ ... }: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "gruvbox-dark";
      simplified_ui = true;
      show_startup_tips = false;
    };
  };
}
