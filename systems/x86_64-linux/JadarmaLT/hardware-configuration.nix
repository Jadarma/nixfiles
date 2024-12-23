{ lib, modulesPath, nixos-hardware, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-nvidia
    nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  # System
  system.stateVersion = "24.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;

  # Bootloader
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ "cryptd" ];
      luks.devices."lvm".device = "/dev/disk/by-label/NIXOS_LUKS";
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  # Drvies, Partitions, and Swap.
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_ROOT";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
      options = [ "umask=0077" ];
    };

    "/home" = {
      device = "/dev/disk/by-label/NIXOS_HOME";
      fsType = "ext4";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/NIXOS_SWAP"; }
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;

    # Nvidia prime settings needed by the `common-gpu-nvidia` imported above.
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
