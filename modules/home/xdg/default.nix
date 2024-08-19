{ config, ... }: {

  xdg = let home = config.home.homeDirectory; in {
    enable = true;

    configHome = "${home}/.config";
    dataHome = "${home}/.local/share";
    cacheHome = "${home}/.cache";
    stateHome = "${home}/.local/state";

    userDirs = {
      enable = true;
      createDirectories = true;

      # Bread and butter.
      documents = "${home}/docs";
      download = "${home}/dl";

      # Media.
      music = "${home}/music";
      pictures = "${home}/pics";
      videos = "${home}/vids";

      # Not really used but defined for completeness.
      desktop = "${home}/desktop";
      publicShare = "${home}/public";
      templates = "${home}/templates";

      # Specialized.
      extraConfig = {
        XDG_REPO_DIR = "${home}/repo"; # Git clones of various projects.
        XDG_SCREENSHOTS_DIR = "${home}/pics/screenshots"; # Separates screenshots from regular pictures.
      };
    };
  };

}
