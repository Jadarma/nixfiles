{ pkgs, ... }: {

  programs.hyprland.enable = true;

  environment =
    {
      systemPackages = with pkgs; [ libnotify ];
      sessionVariables = {
        # Prefer using Ozone because we're under wayland.
        # Otherwise some Electron apps would start under X-Wayland.
        NIXOS_OZONE_WL = "1";
      };
    };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.xserver = {
    enable = true;

    # TODO: Confgiure a more minimal display manager.
    displayManager.gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };
  };
}
