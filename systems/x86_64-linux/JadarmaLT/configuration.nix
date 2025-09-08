{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "JadarmaLT";

  # Nixfiles
  nixfiles.nixos = {
    saneDefaults.enable = true;
    homelab = {
      enable = true;
      shares."/mnt/vault" = { dataset = "pool/vault"; };
    };
  };

  # System-wide packages.
  environment.systemPackages = with pkgs; [
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
