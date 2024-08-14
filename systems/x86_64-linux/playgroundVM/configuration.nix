{ config, pkgs, lib, nixfiles, homeManager, nix-colors, ... }: {
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
      "${nixfiles}/modules/nixos/network"
      "${nixfiles}/modules/nixos/nix"
      "${nixfiles}/modules/nixos/pipewire"
      "${nixfiles}/modules/nixos/shell"
    ];

  # Allow required firmware.
  hardware.enableRedistributableFirmware = true;

  # Enable VM options.
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  networking.hostName = "playgroundVM";

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
  programs.steam.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_DK.UTF-8";
      LC_IDENTIFICATION = "en_DK.UTF-8";
      LC_MEASUREMENT = "en_DK.UTF-8";
      LC_MONETARY = "en_DK.UTF-8";
      LC_NAME = "en_DK.UTF-8";
      LC_NUMERIC = "en_DK.UTF-8";
      LC_PAPER = "en_DK.UTF-8";
      LC_TELEPHONE = "en_DK.UTF-8";
      LC_TIME = "en_DK.UTF-8";
    };
  };

  services.xserver = {
    xkb = {
      layout = "ro";
      variant = "";
    };

    videoDrivers = [ "amdgpu" ];
  };

  # Enable auto-login, this is a VM.
  services.displayManager.autoLogin = {
    enable = true;
    user = "dan_vm";
  };

  # NixOS version at time of install.
  system.stateVersion = "23.11";
}
