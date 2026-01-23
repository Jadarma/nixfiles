{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (osConfig.nixfiles.desktop.enable && pkgs.stdenv.hostPlatform.isLinux) {

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
  };
  xdg.configFile = {
    "waybar/config".source = ./config.json;
    "waybar/modules/clock.json".source = ./modules/clock.json;
    "waybar/modules/cpu.json".source = ./modules/cpu.json;
    "waybar/modules/custom_mako.json".source = ./modules/custom_mako.json;
    "waybar/modules/idle_inhibitor.json".source = ./modules/idle_inhibitor.json;
    "waybar/modules/memory.json".source = ./modules/memory.json;
    "waybar/modules/pulseaudio.json".source = ./modules/pulseaudio.json;

    "waybar/scripts/custom_mako.sh".source = ./scripts/custom_mako.sh;
  };

  # Hyprland integration.
  wayland.windowManager.hyprland.settings = {
    exec-once = [ "waybar" ];
  };
}
