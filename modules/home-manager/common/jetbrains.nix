{ config, pkgs, lib, pkgsUnstable, ... }: {
    home.packages = [ pkgsUnstable.jetbrains.clion ];
}
