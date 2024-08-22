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
        home-manager.users.dan_vm = ./home.nix;
      }
      "${nixfiles}/modules/nixos/bootloader"
      "${nixfiles}/modules/nixos/fonts"
      "${nixfiles}/modules/nixos/gpg"
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
  users.users.dan_vm = {
    isNormalUser = true;
    description = "DanVM";
    extraGroups = [ "networkmanager" "wheel" ];
    useDefaultShell = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "dan_vm";
  };
}
