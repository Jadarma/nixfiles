{ lib, pkgs, ... }:
let
  hostNetworkInterface = "eno1"; # The physical interface to bridge (not Wi-Fi). Will be bridged to `br0`.
  hostIp = "10.10.10.10"; # The IP assigned by router DHCP leases.
  hostMac = "58:11:22:aa:bb:cc"; # The MAC for which the router assigns the `hostIp`. Will be assigned to the bridge.
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
    initrd.kernelModules = lib.mkBefore [
      "kvm-amd"
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "amdgpu"
    ];

    kernelParams = [
      "iommu=pt"
      "amd_iommu=on"
      "pcie_aspm=off"
      ("vfio-pci.ids=" + lib.concatStringsSep "," pciIDs)
    ];

    # Force video driver to be loaded after VFIO.
    # TODO: Workaround for https://github.com/NixOS/nixpkgs/issues/420419
    extraModprobeConfig = ''
      softdep amdgpu pre: vfio vfio_pci
    '';
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
        runAsRoot = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # Create a Networking Bridge.
  networking = {
    enableIPv6 = lib.mkForce false;
    useDHCP = lib.mkForce false;

    interfaces = {
      "virbr0" = {
        useDHCP = lib.mkForce true;
      };
      "${hostNetworkInterface}" = {
        useDHCP = lib.mkForce true;
      };
    };

    # Make NM use dnsmasq, which is required for the bridge.
    networkmanager = {
      enable = true;
      dns = "dnsmasq";
      ethernet.macAddress = hostMac;
    };

    # Allow ports for streaming audio: Scream and Pulse
    firewall.allowedUDPPorts = [ 4010 ];
    firewall.allowedTCPPorts = [ 4713 ];

    # Consider virtual interface as trusted, otherwise firewall might cut-off VM internet.
    firewall.trustedInterfaces = [ "virbr0" ];
  };

  # Stream Audio from Pipewire-Pulse network connection.
  services.pipewire.extraConfig.pipewire-pulse."30-network-stream-receiver" = {
    "pulse.cmd" = [
      {
        cmd = "load-module";
        args = "module-native-protocol-tcp port=4713 listen=${hostIp} auth-anonymous=true";
      }
    ];
  };

  # Stream Audio from Scream (Windows Guest).
  systemd.user.services.scream = {
    enable = true;
    description = "Scream Audio";
    serviceConfig = {
      ExecStart = "${pkgs.scream}/bin/scream -o pulse -u -p 4010 -v";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
    requires = [ "pipewire-pulse.service" ];
  };

  # Install system-wide packages.
  environment.systemPackages = with pkgs; [
    dnsmasq
    pciutils
  ];

  # Other
  users.groups.libvirtd.members = [ "dan" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
