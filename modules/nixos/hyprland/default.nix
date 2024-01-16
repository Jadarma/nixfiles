{ pkgs, config, lib, ... }: {

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [ libnotify ];

  xdg.portal = {
    enable = true;
    # TODO: Because Gnome module is also installed, the GTK portal will conflict.
    #       Uncomment when that is gone.
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
