{ pkgs, config, lib, ... }: {

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [ libnotify ];

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
