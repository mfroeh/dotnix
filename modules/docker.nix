{
  flake.modules.nixos.docker = {
    # will need reboot might have to enable once manually
    # systemctl --user enable --now docker
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
