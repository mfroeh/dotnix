{
  flake.modules.nixos.lambda =
    { config, lib, ... }:
    {
      boot = {
        initrd.availableKernelModules = [
          "xhci_pci"
          "ahci"
          "nvme"
          "usbhid"
          "usb_storage"
          "sd_mod"
        ];
        initrd.kernelModules = [
          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/717484e6-be12-4eb4-b536-f5e4832dd092";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/1758-9FB9";
          fsType = "vfat";
        };
      };

      swapDevices = [
        {
          device = "/swapfile";
          size = 32 * 1024; # 32GB
        }
      ];

      networking = {
        useDHCP = lib.mkDefault true;
        hostName = "lambda";
      };

      hardware = {
        cpu.intel.updateMicrocode = true;
        graphics.enable = true;
        nvidia = {
          modesetting.enable = true;
          # powerManagement is experimental
          powerManagement.enable = true;
          open = false;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
            version = "570.181";
            sha256_64bit = "sha256-8G0lzj8YAupQetpLXcRrPCyLOFA9tvaPPvAWurjj3Pk=";
            sha256_aarch64 = lib.fakeHash;
            openSha256 = "sha256-Fxo0t61KQDs71YA8u7arY+503wkAc1foaa51vi2Pl5I=";
            settingsSha256 = "sha256-VUetj3LlOSz/LB+DDfMCN34uA4bNTTpjDrb6C6Iwukk=";
            persistencedSha256 = lib.fakeHash;
          };
        };

        # enables https://wiki.archlinux.org/title/I2C (at the very least adds the kernel module and some udev rules)
        # then just add users to the i2c group and you can use i2c
        i2c.enable = true;
      };

      nixpkgs.hostPlatform = "x86_64-linux";
    };
}
