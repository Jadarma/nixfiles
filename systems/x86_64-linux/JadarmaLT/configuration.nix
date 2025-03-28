{ pkgs, nixfiles, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
  networking.hostName = "JadarmaLT";
  homelab.nfs.enable = true;

  # System-wide packages.
  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  # User account.
  users.users.dan = {
    description = "Dan Cîmpianu";
    isNormalUser = true;

    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" ];

    createHome = true;
    home = "/home/dan";
    homeMode = "700";

    useDefaultShell = true;
  };
  home-manager.users.dan = ./home.nix;

  # Enable auto-login.
  # This device uses full-disk encryption, a password was already required to boot it.
  # The second password of the single user is therefore just annoying.
  services.displayManager.autoLogin = {
    enable = true;
    user = "dan";
  };
}
