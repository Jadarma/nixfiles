{ lib, pkgs, ... }:
let
  # Radeon RX 7900XTX
  gpuIDs = [
    "1002:744c" # Graphics
    "1002:ab30" # Audio
    "1002:7446" # USB
    "1002:7444" # Serial
  ];
in
{

  # Isolate GPU with VFIO.
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];

    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
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

  # Other
  hardware.graphics.enable = true;
}
