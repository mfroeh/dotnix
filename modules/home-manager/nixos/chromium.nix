{ config, pkgs, lib, ... }: {
  programs = {
    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
        { id = "nngceckbapebfimnlniiiahkandclblb"; }
      ];
    };
  };
}
