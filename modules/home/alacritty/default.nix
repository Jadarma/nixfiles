{ pkgs, config, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        # Blank space added around the window in pixels. This padding is scaled
        # by DPI and the specified value is always added at both opposing sides.
        padding = {
          x = 12;
          y = 12;
        };

        # Window title.
        title = "Terminal";

        # Allow terminal applications to change Alacritty's window title.
        dynamic_title = true;

        # Window class name. Useful for window composite managers.
        class = {
          instance = "Terminal";
          general = "Terminal";
        };
      };

      scrolling = {
        # How many lines are saved in the scroll-back buffer.
        history = 10000;

        # How many lines to jump per scroll step.
        multiplier = 3;
      };

      # Theming
      colors = with config.colorScheme.colors; {

        primary = {
          background = "0x${base00}";
          foreground = "0x${base05}";
        };

        cursor = {
          text = "0x${base00}";
          cursor = "0x${base05}";
        };

        normal = {
          black = "0x${base00}";
          red = "0x${base08}";
          yellow = "0x${base0A}";
          green = "0x${base0B}";
          cyan = "0x${base0C}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          white = "0x${base05}";
        };

        # Make black and white brighter, but keep colors the same.
        bright = {
          black = "0x${base03}";
          red = "0x${base08}";
          yellow = "0x${base0A}";
          green = "0x${base0B}";
          cyan = "0x${base0C}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          white = "0x${base07}";
        };
        draw_bold_text_with_bright_colors = false;
      };

      # Key Bindings
      keyboard.bindings = [
        {
          action = "Copy";
          key = "C";
          mods = "Control|Shift";
        }
        {
          action = "Paste";
          key = "V";
          mods = "Control|Shift";
        }
        {
          action = "PasteSelection";
          key = "Insert";
          mods = "Shift";
        }
        {
          action = "ResetFontSize";
          key = "Key0";
          mods = "Control";
        }
        {
          action = "IncreaseFontSize";
          key = "Plus";
          mods = "Control";
        }
        {
          action = "IncreaseFontSize";
          key = "Equals";
          mods = "Control";
        }
        {
          action = "DecreaseFontSize";
          key = "Minus";
          mods = "Control";
        }
      ];
    };
  };

  # Update environment to specify which terminal is used.
  home.sessionVariables.TERMINAL = "alacritty";
}
