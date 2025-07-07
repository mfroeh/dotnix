{ pkgs, lib, ... }:
{
  programs.nixvim.plugins = {
    lsp.servers.nixd = {
      enable = true;
      settings = {
        formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
      };
    };
  };

  home.packages = [ pkgs.nixfmt-rfc-style ];
}
