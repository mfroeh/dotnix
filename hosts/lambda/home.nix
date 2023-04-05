{ pkgs, config, lib, username, self, ... }: {
  imports = [
    "${self}/modules/home-manager/fish.nix"
    "${self}/modules/home-manager/common/tmux.nix"
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs.home-manager.enable = true;
}
