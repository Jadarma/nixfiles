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
      ];
    })
  ];

  # Hyprland integration.
  wayland.windowManager.hyprland.settings.bind = [
    {
      _args = [
        "SUPER + E"
        (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("dmoji")'')
        { description = "Open the emoji picker."; }
      ];
    }
  ];
}
