{ ... }: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "gruvbox-dark";
      simplified_ui = true;
    };
  };
}
