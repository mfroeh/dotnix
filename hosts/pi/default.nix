  { config, pkgs, lib, inputs, ... }: {
	  imports = [ inputs.nixos-hardware.nixosModules.raspberry-pi-4 ];

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
        options = [ "noatime" ];
      };
    };

	networking.hostName = "pi";

    services.openssh.enable = true;
  }
