{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (osConfig.nixfiles.desktop.enable && pkgs.stdenv.hostPlatform.isLinux) {

  home.packages = with pkgs; [
    (writeShellApplication {
      name = "dmoji";
      text = builtins.readFile ./dmoji.sh;
      runtimeInputs = [
        curl
        frece
        jq
        libnotify
        wl-clipboard
        wofi
      ];
    })

    (writeShellApplication {
      name = "powermenu";
      text = builtins.readFile ./powermenu.sh;
      runtimeInputs = [ wofi ];
    })

    (writeShellApplication {
      name = "snip";
      text = builtins.readFile ./snip.sh;
      runtimeInputs = [
        grim
        hyprland
        jq
        libnotify
        slurp
        swappy
        wl-clipboard
        xdg-user-dirs
      ];
    })
  ];

  # Hyprland integration.
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, E, exec, dmoji"
      "SUPER, escape, exec, powermenu"
    ];
    bindd = [
      # Snip Display
      "SUPER                     , Print, Save a screenshot of the current monitor.         , exec, snip"
      "SUPER + CTRL              , Print, Clip a screenshot of the current monitor.         , exec, snip -c"
      "SUPER +      + SHIFT      , Print, Save and edit a screenshot of the current monitor., exec, snip -a"
      "SUPER + CTRL + SHIFT      , Print, Clip and edit a screenshot of the current monitor., exec, snip -ca"
      # Snip Window
      "SUPER                + ALT, Print, Save a screenshot of the current window.          , exec, snip -w"
      "SUPER + CTRL         + ALT, Print, Clip a screenshot of the current window.          , exec, snip -wc"
      "SUPER        + SHIFT + ALT, Print, Save and edit a screenshot of the current window. , exec, snip -wa"
      "SUPER + CTRL + SHIFT + ALT, Print, Clip and edit a screenshot of the current window. , exec, snip -wac"
      # Snip Selection
      "SUPER                     , S    , Save a screenshot of a selection.                 , exec, snip -s"
      "SUPER + CTRL              , S    , Clip a screenshot of a selection.                 , exec, snip -sc"
      "SUPER        + SHIFT      , S    , Save and edit a screenshot of a selection.        , exec, snip -sa"
      "SUPER + CTRL + SHIFT      , S    , Clip and edit a screenshot of a selection.        , exec, snip -sac"
    ];
  };
}
