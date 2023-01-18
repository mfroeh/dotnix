{ config, pkgs, lib, pkgsUnstable, ... }: {
  home.packages = [ pkgsUnstable.jetbrains.clion ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set number
    set relativenumber
  '';
}
