{ self, inputs, ... }:
{
  flake.modules.homeManager.agenix =
    { pkgs, config, ... }:
    {
      imports = [ inputs.agenix.homeManagerModules.default ];

      home.packages = [
        inputs.agenix.packages.${pkgs.stdenv.system}.default
      ];

      age = {
        identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
        secrets = {
          google-drive-client-id.file = "${self}/secrets/google-drive-client-id.age";
          google-drive-client-secret.file = "${self}/secrets/google-drive-client-secret.age";
          google-drive-token.file = "${self}/secrets/google-drive-token.age";
        };
      };
    };
}
