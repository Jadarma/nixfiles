{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
lib.mkIf (osConfig.nixfiles.programs.discord.enable && pkgs.stdenv.hostPlatform.isLinux) {

  programs.vesktop = {
    enable = true;

    settings = {
      discordBranch = "stable";
      minimizeToTray = true;
      enableSplashScreen = false;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
    };

    vencord.settings = {
      autoUpdate = true;
      autoUpdateNotification = true;

      cloud = {
        authenticated = false;
        settingsSync = false;
      };

      plugins = {
        # Required
        ConcatenatedComponentExtractor.enabled = true;
        DisableDeepLinks.enabled = true;
        NoTrack = {
          enabled = true;
          disableAnalytics = true;
        };
        Settings.enabled = true;
        SupportHelper.enabled = true;
        WebContextMenus.enabeld = true;

        # Optional
        AnonymiseFileNames.enabled = true;
        BiggerStreamPreview.enabled = true;
        ClientTheme = {
          enabled = true;
          color = config.colorScheme.palette.base02;
        };
        CrashHandler.enabled = true;
        GifPaste.enabled = true;
        NoF1.enabled = true;
        StreamerModeOnStream.enabled = true;
        WebScreenShareFixes.enabled = true;
      };
    };
  };
}
