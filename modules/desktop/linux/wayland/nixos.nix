{ config, lib, ... }:
lib.mkIf config.nixfiles.desktop.enable {
  # Enable Graphics.
  services = {
    xserver.enable = true;

    # TODO: Confgiure a more minimal display manager.
    displayManager.gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };
  };

  xdg.portal.enable = true;

  environment.sessionVariables = {
    # Prefer using Ozone because we're under Wayland.
    # Otherwise some Electron apps would start under X-Wayland.
    NIXOS_OZONE_WL = "1";
  };
}
