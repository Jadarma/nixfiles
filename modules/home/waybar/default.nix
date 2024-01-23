{ pkgs, config, ... }: {
  programs.waybar = {
    enable = true;

    style = builtins.readFile ./style.css;

  };
  xdg.configFile = {
    "waybar/config".source = ./config.json;
    "waybar/modules/clock.json".source = ./modules/clock.json;
    "waybar/modules/cpu.json".source = ./modules/cpu.json;
    "waybar/modules/idle_inhibitor.json".source = ./modules/idle_inhibitor.json;
    "waybar/modules/memory.json".source = ./modules/memory.json;
    "waybar/modules/pulseaudio.json".source = ./modules/pulseaudio.json;
  };
}
