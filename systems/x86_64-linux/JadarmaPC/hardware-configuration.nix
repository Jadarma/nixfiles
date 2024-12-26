{ lib, modulesPath, nixos-hardware, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.common-cpu-amd-pstate
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
    kernelParams = [
      "amdgpu.runpm=0"
      "amdgpu.dc=1"
      "amdgpu.gpu_recovery=1"

      "video=HDMI-A-1:2560x1440@144"
      "video=DP-1:2560x1440@144"
      "video=DP-2:2560x1440@144"
    ];
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
