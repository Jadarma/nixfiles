{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (osConfig.nixfiles.desktop.enable && pkgs.stdenv.hostPlatform.isLinux) {

  # Multimedia Keybinds
  wayland.windowManager.hyprland.settings.bind =
    let
      hotkeys = [
        {
          keys = "XF86AudioPlay";
          command = "noctalia msg media toggle";
          description = "Play or pause the current media.";
          flags = {
            locked = true;
          };
        }
        {
          keys = "XF86AudioStop";
          command = "noctalia msg media stop";
          description = "Stop and dismiss current media.";
          flags = {
            locked = true;
          };
        }
        {
          keys = "XF86AudioPrev";
          command = "noctalia msg media previous";
          description = "Play the previous media, if available.";
          flags = {
            locked = true;
          };
        }
        {
          keys = "XF86AudioNext";
          command = "noctalia msg media next";
          description = "Play the next media, if available.";
          flags = {
            locked = true;
          };
        }
        {
          keys = "XF86AudioLowerVolume";
          command = "noctalia msg volume-down";
          description = "Turn down the volume.";
          flags = {
            repeating = true;
            locked = true;
          };
        }
        {
          keys = "XF86AudioRaiseVolume";
          command = "noctalia msg volume-up";
          description = "Turn up the volume.";
          flags = {
            repeating = true;
            locked = true;
          };
        }
        {
          keys = "XF86AudioMute";
          command = "noctalia msg volume-mute";
          description = "Toggle muting the audio.";
          flags = {
            locked = true;
          };
        }
        {
          keys = "XF86AudioMicMute";
          command = "noctalia msg mic-mute";
          description = "Toggle muting the microphone.";
          flags = {
            locked = true;
          };
        }
      ];
      hyprFmt = it: {
        _args = [
          it.keys
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${it.command}")'')
          ((it.flags or { }) // { description = it.description; })
        ];
      };
    in
    map hyprFmt hotkeys;
}
