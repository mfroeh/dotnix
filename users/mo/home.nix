{ lib, pkgs, self, pkgsStable, ... }:
{
  imports = [
    "${self}/home-manager-modules/kitty.nix"
    "${self}/home-manager-modules/tmux.nix"
    "${self}/home-manager-modules/zsh.nix"
    "${self}/home-manager-modules/nvim.nix"
    "${self}/home-manager-modules/fzf.nix"
    "${self}/home-manager-modules/hyperwm.nix"
    "${self}/home-manager-modules/vscode.nix"
  ];

  # https://home-manager-options.extranix.com/?query=services.activitywatch.&release=master
  services.activitywatch = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "mfroeh";
    userEmail = "mfroeh0@pm.me";
    aliases = { s = "status"; };
    extraConfig = {
      init.defaultBranch = "master";
    };
    diff-so-fancy.enable = true;
  };

  home.stateVersion = "24.05";
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "RobotoMono" "Hack" ]; })
  ] ++ [
    discord


    neofetch

    # archivers
    zip
    unzip
    xz
    p7zip

    # utils
    ripgrep
    fd
    jq # lightweight and flexible command-line JSON processor
    yq-go # yaml processor https=//github.com/mikefarah/yq
    eza # modern replacement for ‘ls’
    dust # du in rust
    just
    bat

    # networking tools
    mtr # network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # nix
    nix-tree
    nix-output-monitor # `nom` is an alias for `nix` with detailled log output

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    glow

    # system monitors
    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ] ++ [
    citrix_workspace
    teams-for-linux
  ];
}
