{
  lib,
  pkgs,
  config,
  self,
  inputs,
  ...
}:
with inputs;
{
  imports = [
    ./hardware-configuration.nix
    "${self}/modules/xorg.nix"
    "${self}/modules/kde.nix"
    "${self}/modules/remap.nix"

    "${self}/users/mo"
  ];

  system.stateVersion = "24.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lambda";

  time.timeZone = "Europe/Berlin";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # enable OpenGL
  hardware.graphics.enable = true;

  # load nvidia driver for both Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # powerManagement is experimental
    powerManagement.enable = true;

    # wether to use nouveau driver
    open = false;

    # enable nvidia-settings
    nvidiaSettings = true;

    # optionally select the appropriate driver for your GPU
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "565.77";
      sha256_64bit = "sha256-CnqnQsRrzzTXZpgkAtF7PbH9s7wbiTRNcM0SPByzFHw=";
      sha256_aarch64 = lib.fakeHash;
      openSha256 = "sha256-Fxo0t61KQDs71YA8u7arY+503wkAc1foaa51vi2Pl5I=";
      settingsSha256 = "sha256-VUetj3LlOSz/LB+DDfMCN34uA4bNTTpjDrb6C6Iwukk=";
      persistencedSha256 = lib.fakeHash;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # required for screen sharing on wayland
  services.pipewire.enable = true;

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "mo" ];

  # root shell
  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    coreutils-full
    man-pages

    ntfs3g

    prismlauncher

    config.boot.kernelPackages.perf
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # remap some keys and key combinations
  services.remap.enable = true;
  services.remap.ctrlLeftbraceToEsc = true;

  # disable waking from USB (in particular because of logitech USB receiver)
  # cat /proc/acpi/wakeup
  # cat /sys/class/pci_bus/0000:04/device/0000:04:00.0/vendor
  # cat /sys/class/pci_bus/0000:04/device/0000:04:00.0/device
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}="0x8086" ATTR{device}="0xa36d" ATTR{power/wakeup}="disabled"
  '';
}
