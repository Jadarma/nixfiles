{ lib, pkgs, ... }:
let
  hostNetworkInterface = "eno1";
  pciIDs = [
    "1002:744c" # Radeon RX 7900XTX - Graphics
    "1002:ab30" # Radeon RX 7900XTX - Audio
    "1002:7446" # Radeon RX 7900XTX - USB
    "1002:7444" # Radeon RX 7900XTX - Serial
    "1022:15b7" # USB Hub Motherboard Port
  ];
in
{
  # Isolate GPU and PCI devices with VFIO.
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];

    kernelParams = [
      "iommu=pt"
      ("vfio-pci.ids=" + lib.concatStringsSep "," pciIDs)
    ];
  };

  # Mount VM Storage SSD
  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      gaming_vm      UUID=dd480781-3a84-4620-b733-02b140412218    /etc/luks-keys/gameOnVMStorage.keyfile luks,keyfile-timeout=2s
    '';
  };

  # Enable Libvirt.
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        runAsRoot = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # Create a Networking Bridge.
  networking = {
    useDHCP = lib.mkForce false;
    bridges."br0".interfaces = [ hostNetworkInterface ];
    interfaces = {
      "br0" = {
        useDHCP = lib.mkForce true;
        macAddress = "58:11:22:aa:bb:cc";
      };
      "${hostNetworkInterface}" = {
        useDHCP = lib.mkForce true;
      };
    };

    # Allow ports for streaming audio: Scream and Pulse
    firewall.allowedTCPPorts = [ 4010 4656 ];
  };

  # Other
  users.groups.libvirtd.members = [ "dan" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
