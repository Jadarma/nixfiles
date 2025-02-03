{ config, lib, ... }: {

  # Configure HyprPaper.
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "off";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "${config.xdg.dataHome}/wallpapers/bg_left.png"
        "${config.xdg.dataHome}/wallpapers/bg_center.png"
        "${config.xdg.dataHome}/wallpapers/bg_right.png"
      ];
      wallpaper = lib.mkDefault [ ",${config.xdg.dataHome}/wallpapers/bg_center.png" ];
    };
  };

  # IPC is disabled, so execute HyprPaper once at startup.
  wayland.windowManager.hyprland.settings = {
    exec-once = [ "hyprpaper" ];
  };

  # Import wallpaper image resources.
  xdg.dataFile = {
    "wallpapers/bg_center.png".source = ./wallpapers/bg_center.png;
    "wallpapers/bg_left.png".source = ./wallpapers/bg_left.png;
    "wallpapers/bg_right.png".source = ./wallpapers/bg_right.png;
    "wallpapers/bg_full.png".source = ./wallpapers/bg_full.png;
  };
}
