{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (osConfig.nixfiles.desktop.enable && pkgs.stdenv.hostPlatform.isLinux) {
  services.mako = {
    enable = true;

    settings = with config.colorScheme.palette; {

      # Limit the number of visible notifications.
      max-visible = 10;

      # Sort notifications by most recent first.
      sort = "-time";

      # Default notification appearance.
      anchor = "top-right";
      width = 400;
      height = 150;
      margin = "25";
      padding = "10";
      layer = "top";
      font = "monospace 10";
      border-size = 2;
      border-radius = 0;
      icons = true;
      markup = true;

      # Do not expire notifications that did not set a timeout.
      default-timeout = 0;

      max-history = 10;
      on-button-left = "invoke-default-action";
      on-button-middle = "dismiss-group";
      on-button-right = "dismiss";
      on-touch = "dismiss";

      "mode=do-not-disturb" = {
        invisible = 1;
      };

      "urgency=low" = {
        background-color = "#${base00}";
        text-color = "#${base04}";
        border-color = "#${base02}";
        default-timeout = 10000;
      };

      "urgency=normal" = {
        background-color = "#${base00}";
        text-color = "#${base04}";
        border-color = "#${accent}";
      };

      "urgency=critical" = {
        background-color = "#${base01}";
        text-color = "#${base07}";
        border-color = "#${base0F}";
        ignore-timeout = 1;
        default-timeout = 0;
      };
    };
  };
}
