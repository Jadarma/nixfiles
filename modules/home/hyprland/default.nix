{ pkgs, config, ... }: {

  imports = [
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      exec-once = [ "hyprpaper" ];
    };

    extraConfig = builtins.readFile ./hyprland.conf;
  };

  home.packages = with pkgs; [ hyprpaper ];

  xdg.dataFile = {
    "wallpapers/bg_center.png".source = ./wallpapers/bg_center.png;
    "wallpapers/bg_left.png".source = ./wallpapers/bg_left.png;
    "wallpapers/bg_right.png".source = ./wallpapers/bg_right.png;
    "wallpapers/bg_full.png".source = ./wallpapers/bg_full.png;
  };
  xdg.configFile = {
    "hypr/hyprpaper.conf".text = ''
      ipc = off
      splash = false
      preload = ${config.xdg.dataHome}/wallpapers/bg_center.png
      wallpaper = ,${config.xdg.dataHome}/wallpapers/bg_center.png
    '';
  };
}
