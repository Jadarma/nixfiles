{ pkgs, nixfiles, homeManager, nix-colors, ... }: {

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include VFIO Setup.
      ./vfio.nix
      # Setup home manager.
      homeManager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit nixfiles nix-colors; };
        home-manager.users.dan = ./home.nix;
      }
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

  # System
  networking.hostName = "JadarmaPC";

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
    extraGroups = [ "networkmanager" "wheel" "libvirt" ];

    createHome = true;
    home = "/home/dan";
    homeMode = "700";

    useDefaultShell = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "dan";
  };
}
