{ config
, pkgs
, lib
, ...
}: { 
  imports = [ ./base.nix ];

  home.packages = with pkgs;
    [
      xorg.xwininfo
      wmctrl
      screenkey
      obsidian
    ]
    ++ lib.optionals (pkgs.system == "x86_64-linux") [spotify google-chrome]
    ++ lib.optionals (pkgs.system == "aarch64-linux") [];

  programs = {
    chromium = {
      enable = true;
      extensions = [
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";}
        {id = "dbepggeogbaibhgnhhndojpepiihcmeb";}
        {id = "nngceckbapebfimnlniiiahkandclblb";}
      ];
    };
  };
}
