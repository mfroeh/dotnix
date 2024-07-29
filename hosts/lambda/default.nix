{ lib, pkgs, config, self, inputs, specialArgs, ... }:
with inputs;
{
  imports = [
    ./hardware-configuration.nix
    "${self}/nixos-modules/xorg.nix"
    "${self}/nixos-modules/kde.nix"
    "${self}/nixos-modules/virtualization.nix"
    "${self}/users/mo"
    "${self}/users/work"
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.backupFileExtension = ".backup";
      home-manager.users.mo = import "${self}/users/mo/home.nix";
      home-manager.users.work = import "${self}/users/work/home.nix";
    }
    "${self}/nixos-modules/remap.nix"
  ];
  system.stateVersion = "24.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lambda";

  time.timeZone = "Europe/Stockholm";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # enable OpenGL
  hardware.graphics.enable = true;

  # load nvidia driver for both Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # powerManagement is experimental
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # wether to use nouveau driver
    open = false;

    # enable nvidia-settings
    nvidiaSettings = true;

    # optionally select the appropriate driver for your GPU
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  hardware.pulseaudio.enable = true;

  # required for screen sharing on wayland
  services.pipewire.enable = true;

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    coreutils-full
    man-pages
    config.boot.kernelPackages.perf

    google-chrome
    spotify
    obs-studio
    vlc
    zotero
    gimp
    blender
  ] ++ [

    # create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
    (
      let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
        name = "fhs";
        targetPkgs = pkgs: (
          # pkgs.buildFHSUserEnv provides only a minimal FHS environment, lacking many basic packages needed by most software.
          # Therefore, we need to add them manually.
          # pkgs.appimageTools provides basic packages required by most software.
          (base.targetPkgs pkgs) ++ (with pkgs; [
            pkg-config
            ncurses
            # add more packages here if needed.
          ]
          )
        );
        profile = "export FHS=1";
        runScript = "bash";
        extraOutputsToInstall = [ "dev" ];
      })
    )
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # remap some keys and key combinations
  services.remap.enable = true;
  services.remap.ctrlLeftbraceToEsc = true;
}
