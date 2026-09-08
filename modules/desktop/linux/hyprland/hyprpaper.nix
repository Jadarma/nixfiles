{
  config,
  osConfig,
  lib,
  ...
}:
let
  inherit (lib.attrsets)
    mapAttrs'
    mapAttrsToList
    nameValuePair
    filterAttrs
    attrValues
    ;
  cfg = osConfig.nixfiles.desktop.monitors;
  defaultWallpaper = "${config.xdg.dataHome}/wallpapers/bg_center.png";
  listWithFallback = xs: default: if xs == [ ] then default else xs;
  hyprPaperEntry = monitor: monitorConfig: {
    inherit monitor;
    path = "${config.xdg.dataHome}/wallpapers/${monitorConfig.wallpaper}";
    fit_mode = "cover";
  };
  fallbackEntry = {
    monitor = "";
    path = defaultWallpaper;
    fit_mode = "cover";
  };
  hyprPaperPreload = monitorConfig: "${config.xdg.dataHome}/wallpapers/${monitorConfig.wallpaper}";
in
{
  # Configure HyprPaper.
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "off";
      splash = false;
      splash_offset = 2;

      # Preload all wallpapers in use.
      preload = lib.lists.unique (
        listWithFallback (map hyprPaperPreload (attrValues cfg)) [ defaultWallpaper ]
      );

      # Set wallpapers for their respective monitors.
      wallpaper = listWithFallback (mapAttrsToList hyprPaperEntry cfg) fallbackEntry;
    };
  };

  # IPC is disabled, so execute HyprPaper once at startup.
  wayland.windowManager.hyprland.settings.on = [
    {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"hyprpaper\")\nend")
      ];
    }
  ];

  # Symlink wallpaper image resources.
  xdg.dataFile = mapAttrs' (
    name: _: nameValuePair "wallpapers/${name}" { source = ./wallpapers/${name}; }
  ) (filterAttrs (_: v: v == "regular") (builtins.readDir ./wallpapers));
}
