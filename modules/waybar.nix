{
  flake.modules.homeManager.waybar =
    { pkgs, ... }:
    {
      programs.waybar = {
        enable = true;
        settings.mainBar = {
          modules-left = [
            "niri/workspaces"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "pulseaudio"
            "pulseaudio#mic"
            "disk"
            "memory"
            "custom/gpu"
            "cpu"
            "tray"
          ];

          clock = {
            format = "{:%Y-%m-%d %H:%M}";
            tooltip-format = "{:%A, %B %d, %Y}";
            interval = 1;
          };

          cpu = {
            format = "󰻠 {usage:>2}%";
            interval = 2;
          };

          memory = {
            format = "󰍛 {used:0.1f}/{total:0.1f}G";
            interval = 2;
          };

          disk = {
            format = "󰋊 {specific_used:0.1f}/{specific_total:0.1f}G";
            unit = "GiB";
            interval = 30;
          };

          tray = {
            spacing = 8;
          };

          "custom/gpu" = {
            exec = "${pkgs.writeShellScript "gpu-usage" ''
              u=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)
              [ -n "$u" ] && printf "󰢮 %2s%%\n" "$u"
            ''}";
            interval = 2;
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "󰖁 muted";
            format-icons.default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            on-click = "pavucontrol";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };

          "pulseaudio#mic" = {
            format = "{format_source}";
            format-source = "󰍬 {volume}%";
            format-source-muted = "󰍭 muted";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };
        };
      };

      services.network-manager-applet.enable = true;

      home.packages = [
        pkgs.pavucontrol
      ];
    };
}
