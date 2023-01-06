{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./i3.nix ./rofi.nix ./gtk.nix ];

  home.packages = with pkgs;
    [
      xorg.xwininfo
      wmctrl
      screenkey
      obsidian
    ]
    ++ lib.optionals (pkgs.system == "x86_64-linux") [spotify obsidian google-chrome bitwarden];

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
