# XDG
# Configure directory specifications for standardized file locations.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  home = config.home.homeDirectory;
in
{
  xdg = {
    enable = true;

    # Ubiquitous directories used by almost all decent programs.
    configHome = "${home}/.config";
    dataHome = "${home}/.local/share";
    cacheHome = "${home}/.cache";
    stateHome = "${home}/.local/state";

    userDirs = {
      # User dirs only available on NixOS, alternative below.
      enable = pkgs.stdenv.isLinux;
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

  # Make programs use XDG directories whenever supported.
  home.preferXdgDirectories = true;

  # Set the XDG variables manually for consistency in Darwin.
  home.sessionVariables = lib.mkIf pkgs.stdenv.isDarwin {
    XDG_DESKTOP_DIR = "${home}/Desktop";
    XDG_DOCUMENTS_DIR = "${home}/Documents";
    XDG_DOWNLOAD_DIR = "${home}/Downloads";
    XDG_MUSIC_DIR = "${home}/Music";
    XDG_PICTURES_DIR = "${home}/Pictures";
    XDG_PUBLICSHARE_DIR = "${home}/Public";
    XDG_VIDEOS_DIR = "${home}/Movies";
    XDG_REPO_DIR = "${home}/repo";
    XDG_SCREENSHOTS_DIR = "${home}/Pictures/Screenshots";
  };
}
