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
      setSessionVariables = true;

      # Bread and butter.
      documents = "${home}/docs";
      download = "${home}/dl";
      projects = "${home}/repo";

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
        SCREENSHOTS = "${home}/pics/screenshots"; # Separates screenshots from regular pictures.
      };
    };
  };

  # Make programs use XDG directories whenever supported.
  home.preferXdgDirectories = true;

  # Set the XDG variables manually for consistency in Darwin.
  home.sessionVariables = lib.mkIf pkgs.stdenv.isDarwin {
    XDG_DOCUMENTS_DIR = "${home}/Documents";
    XDG_DOWNLOAD_DIR = "${home}/Downloads";
    XDG_PROJECTS_DIR = "${home}/repo";
    XDG_MUSIC_DIR = "${home}/Music";
    XDG_PICTURES_DIR = "${home}/Pictures";
    XDG_VIDEOS_DIR = "${home}/Movies";
    XDG_DESKTOP_DIR = "${home}/Desktop";
    XDG_PUBLICSHARE_DIR = "${home}/Public";
    XDG_SCREENSHOTS_DIR = "${home}/Pictures/Screenshots";
  };
}
