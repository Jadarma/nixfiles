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
      # Shell
      "${nixfiles}/modules/nixos/shell"
      # Fonts
      "${nixfiles}/modules/nixos/fonts"
      # Hyprland
      "${nixfiles}/modules/nixos/hyprland"
      # GNUPG
      "${nixfiles}/modules/nixos/gpg"
    ];

  # Enable Nix Flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages as well as required firmware.
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  # Enable VM options.
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Enable networking.
  networking = {
    hostName = "playgroundVM";
    networkmanager.enable = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Install system-wide packages.
  environment.systemPackages = with pkgs; [
    neovim
    pciutils
    git
    pulseaudio
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dan_vm = {
    isNormalUser = true;
    description = "DanVM";
    extraGroups = [ "networkmanager" "wheel" ];
    useDefaultShell = true;
    packages = with pkgs; [
      vesktop
      pcmanfm
      pavucontrol
      keepassxc
      protonup-ng
      spotify
    ];
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
