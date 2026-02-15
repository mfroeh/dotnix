{
  flake.modules.homeManager.rclone =
    { config, ... }:
    {
      programs.rclone = {
        enable = true;
        requiresUnit = "agenix.service";
        remotes = {
          # rclone config reconnect google-drive: to obtain new access token
          "google-drive" = {
            secrets = {
              client_id = config.age.secrets.google-drive-client-id.path;
              client_secret = config.age.secrets.google-drive-client-secret.path;
              token = config.age.secrets.google-drive-token.path;
            };
            config = {
              type = "drive";
              scope = "drive";
              team_drive = "";
            };
            mounts = {
              "/" = {
                enable = true;
                mountPoint = "${config.home.homeDirectory}/google-drive";
                options = {
                  vfs-cache-mode = "full";
                  vfs-read-ahead = "128M";
                };
              };
            };
          };
        };
      };

      home.file = {
        "Journal".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/google-drive/Journal";
        "Notes".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/google-drive/Notes";
      };
    };
}
