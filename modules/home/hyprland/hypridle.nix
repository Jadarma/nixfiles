{ pkgs, config, ... }: {

  # Configure HyprIdle
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "hyprlock";
        ignore_dbus_inhibit = false;

        # Lock before suspend, and automatically turn displays on when resuming.
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Lock the desktop after 20 minutes of inactivity.
        {
          timeout = 1200;
          on-timeout = "hyprlock";
        }
        # Turn the monitors off to conserve power after 30 minutes of inactivity.
        {
          timeout = 1800;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
