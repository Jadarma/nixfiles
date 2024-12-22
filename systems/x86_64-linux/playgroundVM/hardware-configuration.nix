{ pkgs, lib, modulesPath, nixos-hardware, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    nixos-hardware.nixosModules.common-pc-ssd
    nixos-hardware.nixosModules.common-gpu-amd
  ];

  # System
  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;

  # Bootloader
  boot = {
    initrd = {
      availableKernelModules = [ "ahci" "xhci_pci" "amdgpu" "virtio_pci" "virtio_scsi" "usbhid" "sr_mod" "virtio_blk" ];
      kernelModules = [ "amdgpu" ];
    };
    kernelModules = [ "kvm-amd" ];
    supportedFilesystems = [ "ntfs" ];
    extraModulePackages = [ ];
    extraModprobeConfig = ''
      options amdgpu gpu_recovery=1
      options amdgpu lbpw=1
      options amdgpu dpm=1
    '';
  };

  # Drives, Partitions, and Swap.
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8722b458-e564-4946-8631-554b19779cfc";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/A5F5-C997";
      fsType = "vfat";
    };

    "/home/dan/games" = {
      device = "/dev/disk/by-label/Games";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" "gid=100" "noatime" "nofail" "utf8" ];
    };
  };

  swapDevices = [ ];

  # AMD GPU
  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  # Virtual machine settings.
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;
}
