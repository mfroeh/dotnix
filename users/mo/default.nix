{ pkgs, lib, ... }:
{
  users.users.mo =
    {
      description = "mfroeh";
      shell = pkgs.zsh;
    }
    // lib.optionalAttrs pkgs.stdenv.isLinux {
      home = "/home/mo";
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "audio"
        "video"
        "vboxusers"
        "docker"
      ];
      initialPassword = "";
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
      home = "/Users/mo";
    };
}
