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
  wayland.windowManager.hyprland.settings.bind =
    let
      commands = [
        {
          keys = "SUPER + E";
          command = "dmoji";
          description = "Open the emoji picker.";
        }
        {
          keys = "SUPER + escape";
          command = "powermenu";
          description = "Open the power menu.";
        }
        # Snip - Whole Display
        {
          keys = "SUPER + Print";
          command = "snip";
          description = "Save a screenshot of the current monitor.";
        }
        {
          keys = "SUPER + CTRL + Print";
          command = "snip -c";
          description = "Clip a screenshot of the current monitor.";
        }
        {
          keys = "SUPER + SHIFT + Print";
          command = "snip -a";
          description = "Save and edit a screenshot of the current monitor.";
        }
        {
          keys = "SUPER + CTRL + SHIFT + Print";
          command = "snip -ca";
          description = "Clip and edit a screenshot of the current monitor.";
        }
        # Snip - Window
        {
          keys = "SUPER + ALT + Print";
          command = "snip -w";
          description = "Save a screenshot of the active window.";
        }
        {
          keys = "SUPER + CTRL + ALT + Print";
          command = "snip -wc";
          description = "Clip a screenshot of the active window.";
        }
        {
          keys = "SUPER + SHIFT + ALT + Print";
          command = "snip -wa";
          description = "Save and edit a screenshot of the active window.";
        }
        {
          keys = "SUPER + CTRL + SHIFT + ALT + Print";
          command = "snip -wca";
          description = "Clip and edit a screenshot of the active window.";
        }
        #Snip - Selection
        {
          keys = "SUPER + S";
          command = "snip -s";
          description = "Save a screenshot of a selection.";
        }
        {
          keys = "SUPER + CTRL + S";
          command = "snip -sc";
          description = "Clip a screenshot of a selection.";
        }
        {
          keys = "SUPER + SHIFT + S";
          command = "snip -sa";
          description = "Save and edit a screenshot of a selection.";
        }
        {
          keys = "SUPER + CTRL + SHIFT + S";
          command = "snip -sca";
          description = "Clip and edit a screenshot of a selection.";
        }
      ];
      luaFormat = cmd: {
        _args = [
          cmd.keys
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${cmd.command}")'')
          { description = cmd.description; }
        ];
      };
    in
    map luaFormat commands;
}
