{ pkgs, config, ... }: {

  imports = [
    ./hyprcursor.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
