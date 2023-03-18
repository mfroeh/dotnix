{ config, pkgs, lib, platform, ... }: {
  programs.vscode = {
    enable = true;
    package = if platform.aarch64-linux then pkgs.vscode else pkgs.vscode.fhsWithPackages (ps: with ps; []);
  };
}
