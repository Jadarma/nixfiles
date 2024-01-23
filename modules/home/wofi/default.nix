{ pkgs, config, ... }: {
  programs.wofi = {
    enable = true;

    settings = {
      allow_images = true;
      content_halign = "start";
      gtk_dark = true;
      image_size = 24;
      location = "top";
      no_actions = true;
      term = "alacritty";
      width = "100%";
    };

    # TODO: Use color scheme variables for the colors.
    style = builtins.readFile ./style.css;
  };
}
