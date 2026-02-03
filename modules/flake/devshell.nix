{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem =
    { pkgs, config, ... }:
    {
      pre-commit = {
        settings.hooks = {
          treefmt.enable = true;
        };
      };
      treefmt = {
        programs = {
          stylua.enable = true;
          deadnix.enable = true;
          keep-sorted.enable = true;
          nixf-diagnose.enable = true;
          nixfmt.enable = true;
          statix.enable = true;
        };
        settings.formatter.nixf-diagnose.options = [
          "--ignore"
          "sema-unused-def-let"
        ];
        settings.formatter.deadnix.options = [ "--no-underscore" ];
        settings.global.excludes = [ "**/__*" ];
      };

      devShells.default = pkgs.mkShell {
        shellHook = config.pre-commit.installationScript;
        buildInputs = [ config.treefmt.build.wrapper ];
      };
    };
}
