{ pkgs, lib, ... }:
let
  neohtopWrapper = pkgs.writeShellScriptBin "neohtop-wrapped-user" ''
    export GDK_BACKEND=x11
    export WEBKIT_DISABLE_DMABUF_RENDERER=1
    exec ${pkgs.neohtop}/bin/NeoHtop "$@"
  '';
in
{
  config = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux {
      home.packages = [
        neohtopWrapper
      ];
      xdg.desktopEntries.neohop-wrapped = {
        exec = "${neohtopWrapper}/bin/neohtop-wrapped-user";
        name = "NeoHtop (wrapped for Wayland)";
        terminal = false;
        type = "Application";
      };
    })

    (lib.mkIf (!pkgs.stdenv.isDarwin) {
      home.packages = [ pkgs.neohtop ];
    })
  ];
}
