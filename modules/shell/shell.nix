{ inputs, ... }:
{
  flake.modules.nixos.shell = {
    imports = [ inputs.self.modules.nixos.zsh ];
    home-manager.sharedModules = [ inputs.self.modules.homeManager.shell ];
  };

  flake.modules.darwin.shell = {
    imports = [ inputs.self.modules.darwin.zsh ];
    home-manager.sharedModules = [ inputs.self.modules.homeManager.shell ];
  };

  flake.modules.homeManager.shell = {
    imports = with inputs.self.modules.homeManager; [
      archivers
      atuin
      cli
      env
      man
      nixRelated
      zellij
      zoxide
      zsh
    ];
  };
}
