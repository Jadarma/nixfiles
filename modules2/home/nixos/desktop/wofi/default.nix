{ config, lib, ... }:
let cfg = config.nixfiles.home.desktop; in {

  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;

      settings = {
        allow_images = true;
        content_halign = "start";
        gtk_dark = true;
        image_size = 24;
        location = "top";
        no_actions = true;
        # TODO: Can this be detected automatically?
        term = "alacritty";
        width = "100%";
      };

      # TODO: Use color scheme variables for the colors.
      style = builtins.readFile ./style.css;
    };

    # Hyprland integration.
    wayland.windowManager.hyprland.settings = {
      # NOTE: Bodgy hack here.
      #       Because hyprland doesn't source the `home.sessionVariables`, force the menu to be launched by an intermediary
      #       shell, that way ZSH will do the environment sourcing for you. This is important because without it, programs
      #       won't have the same environment as your terminal, and IDEs won't be able to use GPG/SSH for instance.
      bind = [
        "SUPER, D, exec, /usr/bin/env zsh -ic 'pgrep wofi || wofi --show drun -D orientation=horizontal --lines=1 --prompt=\"Search Applications…\"'"
      ];

      layerrule = [
        "dimaround, wofi"
        # Use specific animation.
        # TODO: Seems like only works for exit animation.
        "animation slide top, wofi"
      ];
    };
  };
}
