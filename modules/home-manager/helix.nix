{
  config,
  pkgs,
  lib,
  ...
} : {
  programs.helix = {
    enable = true;
    languages = [
      {
        name = "nix";
        auto-format = true;
      }
    ];
    settings = {
      theme = "gruvbox";
      # lsp.display-messages = true;
    };
  };
}
