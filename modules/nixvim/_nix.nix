{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{

  userCommands = {
    NixExpand = {
      command = '':exe ":normal! $F.cl={\<esc>A};"'';
    };
  };

  plugins.lsp.servers.nixd = {
    enable = true;
    settings = {
      formatting.command = [ "${lib.getExe pkgs.nixfmt}" ];
      nixpkgs.expr = "import <nixpkgs> {}";
      options = {
        # home-manager.expr = ''(builtins.getFlake (builtins.toString ~/dotnix)).homeConfigurations."${home-config-name}".options'';
        nixvim.expr = ''(builtins.getFlake (builtins.toString ~/dotnix)).inputs.nixvim.nixvimConfigurations."${system}".default.options'';
      }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        nixos.expr = "(builtins.getFlake (builtins.toString ~/dotnix)).nixosConfigurations.lambda.options";
        nixos-home-manager.expr = "(builtins.getFlake (builtins.toString ~/dotnix)).nixosConfigurations.lambda.options.home-manager.users.type.getSubOptions []";
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        darwin.expr = "(builtins.getFlake (builtins.toString ~/dotnix)).darwinConfigurations.xya.options";
      };
    };
  };
}
