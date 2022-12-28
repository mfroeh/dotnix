{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wallpaper;
in {
  options.wallpaper = {
    enable = mkEnableOption "options file";
    file = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    # tell application "System Events" to tell every desktop to set picture to "${cfg.file}" as POSIX file
  };
}
