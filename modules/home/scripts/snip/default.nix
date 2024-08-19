{ pkgs, ... }: {
  # Create the snip script.
  home.packages = with pkgs;
    let
      snip = {
        name = "snip";
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
        text = builtins.readFile ./snip.sh;
      };
    in
    [ (writeShellApplication snip) ];

  # Hyprland integration.
  wayland.windowManager.hyprland.settings = {
    bindd = [
      # Display
      "SUPER                     , Print, Save a screenshot of the current monitor.         , exec, snip"
      "SUPER + CTRL              , Print, Clip a screenshot of the current monitor.         , exec, snip -c"
      "SUPER +      + SHIFT      , Print, Save and edit a screenshot of the current monitor., exec, snip -a"
      "SUPER + CTRL + SHIFT      , Print, Clip and edit a screenshot of the current monitor., exec, snip -ca"
      # Window
      "SUPER                + ALT, Print, Save a screenshot of the current window.          , exec, snip -w"
      "SUPER + CTRL         + ALT, Print, Clip a screenshot of the current window.          , exec, snip -wc"
      "SUPER        + SHIFT + ALT, Print, Save and edit a screenshot of the current window. , exec, snip -wa"
      "SUPER + CTRL + SHIFT + ALT, Print, Clip and edit a screenshot of the current window. , exec, snip -wac"
      # Selection
      "SUPER                     , S    , Save a screenshot of a selection.                 , exec, snip -s"
      "SUPER + CTRL              , S    , Clip a screenshot of a selection.                 , exec, snip -sc"
      "SUPER        + SHIFT      , S    , Save and edit a screenshot of a selection.        , exec, snip -sa"
      "SUPER + CTRL + SHIFT      , S    , Clip and edit a screenshot of a selection.        , exec, snip -sac"
    ];
  };
}
