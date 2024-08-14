{ pkgs, lib, ... }: {

  # Use latest stable kernel by default.
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  # Enable systemd-boot.
  boot.loader = {

    systemd-boot = {
      enable = true;
      editor = false;

      configurationLimit = lib.mkDefault 128;
    };

    efi.canTouchEfiVariables = lib.mkDefault true;
  };
}
