{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./vfio.nix
  ];

  networking.hostName = "JadarmaPC";

  # Nixfiles
  nixfiles.nixos = {
    saneDefaults.enable = true;
    homelab.enable = true;
    android.enable = true;
  };

  # Install system-wide packages.
  environment.systemPackages = with pkgs; [
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
