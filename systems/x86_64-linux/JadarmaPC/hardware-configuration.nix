{ lib, modulesPath, nixos-hardware, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  # Sytem
  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Bootloader
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "ahci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "cryptd" "dm-snapshot" ];
      luks.devices."cryptroot".device = "/dev/disk/by-label/NIXOS_LUKS";
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  # Drives, Partitions, and Swap.
  fileSystems = {
    "/" =
      {
        device = "/dev/disk/by-label/NIXOS_ROOT";
        fsType = "ext4";
        options = [ "noatime" ];
      };
    "/boot" =
      {
        device = "/dev/disk/by-label/NIXOS_BOOT";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
    "/home" =
      {
        device = "/dev/disk/by-label/NIXOS_HOME";
        fsType = "ext4";
        options = [ "noatime" ];
      };
  };

  swapDevices = [{ device = "/dev/disk/by-label/NIXOS_SWAP"; }];

  # CPU
  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
}
