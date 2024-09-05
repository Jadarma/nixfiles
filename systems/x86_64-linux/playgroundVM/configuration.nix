{ pkgs, nixfiles, homeManager, nix-colors, ... }: {
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Setup home manager.
      homeManager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit nixfiles nix-colors; };
        home-manager.users.dan = ./home.nix;
      }
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
      "${nixfiles}/modules/nixos/steam"
    ];

  # System.
  networking.hostName = "playgroundVM";
  system.stateVersion = "23.11";

  # Install system-wide packages.
  environment.systemPackages = with pkgs; [
    neovim
    pciutils
    git
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dan = {
    description = "Dan Cîmpianu";
    isNormalUser = true;

    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" ];

    createHome = true;
    home = "/home/dan";
    homeMode = "700";

    useDefaultShell = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "dan";
  };

  virtualisation.docker.enable = true;
}
