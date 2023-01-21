{ config, pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    # Doesn't work on aarch64 :/
    # package = pkgs.vscode.fhsWithPackages (ps: with ps; []);
    package = pkgs.vscode;
    userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
    };
  };
}
