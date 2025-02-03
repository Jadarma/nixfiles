{ config, lib, ... }:
let cfg = config.nixfiles.home.programs.cava; in {
  options = {
    nixfiles.home.programs.cava = {
      enable = lib.mkEnableOption "Cava (Terminal Audio Visualizer)";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.cava = {
      enable = true;

      settings = {
        general = {
          framerate = 60;
          autosens = 1;
          overshoot = 20;

          bars = 0;
          bar_width = 2;
          bar_spacing = 1;
        };

        output = {
          method = "ncurses";
          channels = "stereo";
          mono_option = "average";

          alacritty_sync = config.programs.alacritty.enable;
        };

        color = with config.colorScheme.palette; {
          background = "default";
          foreground = "default";

          gradient = 1;
          gradient_count = 6;

          gradient_color_1 = "'#${base0E}'";
          gradient_color_2 = "'#${base0D}'";
          gradient_color_3 = "'#${base0C}'";
          gradient_color_4 = "'#${base0B}'";
          gradient_color_5 = "'#${base0A}'";
          gradient_color_6 = "'#${base08}'";
        };

        smoothing = {
          noise_reduction = 75;
        };
      };
    };
  };
}
