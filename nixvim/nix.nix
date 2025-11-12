{
  pkgs,
  lib,
  nixos-config-name,
  home-config-name,
  system,
  inputs,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers.nixd = {
      # until https://github.com/nix-community/nixd/issues/653 closed
      package = inputs.nixd-completion-in-attr-sets-fix.packages.${system}.nixd;
      enable = true;
      settings = {
        formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
        nixpkgs = {
          expr = "(builtins.getFlake (builtins.toString ~/dotnix)).inputs.nixpkgs";
        };
        options = {
          nixos = {
            expr = ''(builtins.getFlake (builtins.toString ~/dotnix)).nixosConfigurations."${nixos-config-name}".options'';
          };
          home-manager = {
            expr = ''(builtins.getFlake (builtins.toString ~/dotnix)).homeConfigurations."${home-config-name}".options'';
          };
          nixvim = {
            expr = ''(builtins.getFlake (builtins.toString ~/dotnix)).inputs.nixvim.nixvimConfigurations."${system}".default.options'';
          };
        };
      };
    };
  };

  home.packages = [ pkgs.nixfmt-rfc-style ];
}
