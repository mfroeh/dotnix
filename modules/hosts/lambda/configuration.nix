{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "lambda";

  flake.modules.nixos.lambda = {
    imports = with inputs.self.modules.nixos; [
      locale
      remaps
      mo

      personalApps
      shell
      nixvim
      stylix
      steam
      niri
    ];

    system.stateVersion = "25.11";

    # disable waking from USB (in particular because of logitech USB receiver)
    # cat /proc/acpi/wakeup
    # cat /sys/class/pci_bus/0000:04/device/0000:04:00.0/vendor
    # cat /sys/class/pci_bus/0000:04/device/0000:04:00.0/device
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}="0x8086" ATTR{device}="0xa36d" ATTR{power/wakeup}="disabled"
    '';

    # DBus service that allows applications (in particular file managers) to query and mount storage devices
    services.udisks2.enable = true;

    # TODO: if graphics don't work, first enable this (but as I understand, this should be xorg only)
    services.xserver.videoDrivers = [ "nvidia" ];

    # TODO: maybe check what we can make modular here (and what we still need)
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    # TODO: required for screen sharing on wayland
    # services.pipewire.enable = true;
  };
}
