{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "lambda";

  flake.modules.nixos.lambda =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        locale
        remaps
        mo

        personalApps
        docker
        shell
        nixvim
        stylix
        steam
        niri
      ];

      environment.systemPackages = with pkgs; [
        ghidra-bin
      ];

      system.stateVersion = "25.11";

      # disable waking from USB (in particular because of logitech USB receiver)
      # cat /proc/acpi/wakeup
      # cat /sys/class/pci_bus/0000:04/device/0000:04:00.0/vendor
      # cat /sys/class/pci_bus/0000:04/device/0000:04:00.0/device
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}="0x8086" ATTR{device}="0xa36d" ATTR{power/wakeup}="disabled"
      '';

      services.xserver.videoDrivers = [ "nvidia" ];
      networking.networkmanager.enable = true;

      # TODO: required for screen sharing on wayland
      # services.pipewire.enable = true;
    };
}
