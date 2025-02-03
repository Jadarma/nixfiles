{ pkgs, nixfiles, ... }: {
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

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
  home-manager.users.dan = ./home.nix;

  services.displayManager.autoLogin = {
    enable = true;
    user = "dan";
  };

  virtualisation.docker.enable = true;

  # Stram Audio to Host
  services.pipewire.extraConfig.pipewire-pulse."30-network-stream-sender" = {
    "pulse.cmd" = [
      {
        cmd = "load-module";
        args = "module-tunnel-sink server=tcp:10.10.10.10:4713 reconnect_interval_ms=5000";
      }
    ];
  };
}
