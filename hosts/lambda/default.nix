{ lib, pkgs, config, self, inputs, specialArgs, ... }:
with inputs;
{
  imports = [
    ./hardware-configuration.nix
    "${self}/modules/xorg.nix"
    "${self}/modules/kde.nix"
    "${self}/users/mo"
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.backupFileExtension = ".backup";
      home-manager.users.mo = import "${self}/users/mo/home.nix";
    }
    "${self}/modules/remap.nix"
  ];
  system.stateVersion = "24.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lambda";

  time.timeZone = "Europe/Stockholm";
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

  # docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "mo" ];
}
