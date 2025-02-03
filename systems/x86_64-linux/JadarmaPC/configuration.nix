{ pkgs, nixfiles, ... }: {

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include VFIO Setup.
      ./vfio.nix
      "${nixfiles}/modules/nixos/android"
      "${nixfiles}/modules/nixos/bootloader"
      "${nixfiles}/modules/nixos/fonts"
      "${nixfiles}/modules/nixos/gpg"
      "${nixfiles}/modules/nixos/homelab"
      "${nixfiles}/modules/nixos/hyprland"
      "${nixfiles}/modules/nixos/locale"
      "${nixfiles}/modules/nixos/network"
      "${nixfiles}/modules/nixos/nix"
      "${nixfiles}/modules/nixos/pipewire"
      "${nixfiles}/modules/nixos/shell"
    ];

  # Homelab
  networking.hostName = "JadarmaPC";
  homelab.nfs.enable = true;

  # Install system-wide packages.
  environment.systemPackages = with pkgs; [
    neovim
    pciutils
    git
  ];

  # Define a user account.
  users.groups.dan.gid = 1000;
  users.users.dan = {
    description = "Dan Cîmpianu";
    isNormalUser = true;

    uid = 1000;
    group = "dan";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" ];

    createHome = true;
    home = "/home/dan";
    homeMode = "700";

    useDefaultShell = true;
  };
  home-manager.users.dan = ./home.nix;

  # Only allow Suspend to RAM.
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  virtualisation.docker.enable = true;
}
