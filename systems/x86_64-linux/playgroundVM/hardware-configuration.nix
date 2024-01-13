{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    initrd = {
      availableKernelModules = [ "ahci" "xhci_pci" "amdgpu" "virtio_pci" "virtio_scsi" "usbhid" "sr_mod" "virtio_blk" ];
      kernelModules = [ "amdgpu" ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    extraModprobeConfig = ''
      options amdgpu gpu_recovery=1
      options amdgpu lbpw=1
      options amdgpu dpm=1
    '';
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/3714ee2c-293a-443d-b27e-b488fe81484e";
      fsType = "ext4";
    };

    "/boot" =
      {
        device = "/dev/disk/by-uuid/0CE2-006A";
        fsType = "vfat";
      };

    swapDevices = [ ];
  };

  networking = {
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # interfaces.enp2s0.useDHCP = lib.mkDefault true;
  };
}
