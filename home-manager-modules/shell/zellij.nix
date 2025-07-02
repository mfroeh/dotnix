{ ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "nightfox";
      simplified_ui = true;
      show_startup_tips = false;
    };
  };
}
