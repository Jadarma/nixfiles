{ pkgs, config, ... }: {

  imports = [
    ./hyprcursor.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpicker.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      exec-once = [
        "notify-send -u low -t 2500 'Welcome!' 'To <i>Hyprland!</i>'"
      ];
    };

    # TODO: Extra configs.
    # Throw in temporary extra config here.
    # This should ideally be empty, and put in relevant modules.
    extraConfig = ''
      bind = SUPER, F3, exec, pcmanfm
    '';
  };
}
