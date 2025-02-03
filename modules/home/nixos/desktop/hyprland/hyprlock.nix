{ config, ... }: {

  # Configure HyprLock.
  programs.hyprlock = {
    enable = true;

    # TODO: Do not hardcode colors used in HyprLock.
    settings = {
      # General Settings.
      general = {
        disable_loading_bar = true;
        ignore_empty_input = true;
      };

      # Background Image with Blur.
      background = {
        color = "rgb(1b2529)";
        path = "${config.xdg.dataHome}/wallpapers/bg_center.png";

        blur_passes = 2;
        blur_size = 3;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      # Password Field
      input-field = {
        size = "196, 32";
        position = "0, -400";
        halign = "center";
        valign = "center";

        outline_thickness = 2;
        swap_font_color = false;

        dots_size = 0.25;
        dots_spacing = 0.55;
        dots_center = true;
        dots_rounding = -1;

        placeholder_text = "";
        fail_text = ''<span face='JetBrainsMono Nerd Font'>$FAIL <b>($ATTEMPTS)</b></span>'';

        hide_input = false;
        fade_on_empty = true;
        fail_transition = 100;
        invert_numlock = true;

        font_color = "rgb(eaeaea)";
        outer_color = "rgb(2e3c43)";
        inner_color = "rgb(2e3c43)";
        check_color = "rgb(2e3c43)";
        fail_color = "rgb(ff5370)";
        capslock_color = "rgb(ffcb6b)";
        numlock_color = "rgb(ffcb6b)";
        bothlock_color = -1;
      };

      # Labels
      label = [
        # Date
        {
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';

          position = "0, 400";
          halign = "center";
          valign = "center";

          font_family = "JetBrainsMono NFM SemiBold";
          font_size = 16;
          color = "rgb(eaeaea)";
        }
        # Time
        {
          text = ''cmd[update:1000] echo "$(date +"%k:%M")"'';

          position = "0, 300";
          halign = "center";
          valign = "center";

          font_family = "JetBrainsMono NFM ExtraBold";
          font_size = 96;
          color = "rgb(eaeaea)";
        }
        # Footer
        {
          position = "0, 16";
          halign = "center";
          valign = "bottom";

          text = "Logged in as $DESC. Type password to unlock.";

          text_align = "center";
          color = "rgb(b2ccd6)";
          font_size = 8;
          font_family = "JetBrainsMono NFP Light";
        }
      ];
    };
  };

  # Add keybinds.
  wayland.windowManager.hyprland.settings = {
    bind = [
      # HyprLock is called by HyprIdle whenever a dbus lock event occurs.
      # Instead of calling it manually, we trigger the event to get the same effect.
      "SUPER + SHIFT, escape, exec, loginctl lock-session"
    ];
  };
}
