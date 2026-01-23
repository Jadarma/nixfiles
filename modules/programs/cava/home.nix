{
  config,
  osConfig,
  lib,
  ...
}:
lib.mkIf osConfig.nixfiles.programs.cava.enable {
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
}
