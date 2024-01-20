{ pkgs, config, ... }: {

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = "uint32 0";
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
      workspaces-only-on-primary = false;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "trayIconsReloaded@selfmade.pl"
      ];
    };
    "org/gnome/system/location" = {
      enabled = false;
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.tray-icons-reloaded
  ];
}
