{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.programs.steam.enable {

  # Enable Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Gamescope integration is a little buggy, see:
  # - https://github.com/ValveSoftware/gamescope/issues/697#issuecomment-2564875728
  # - https://github.com/NixOS/nixpkgs/issues/351516
  # Example Steam Launch Options:
  # LD_PRELOAD= gamescope -f -w 2560 -h 1440 -r 144 --adaptive-sync --framerate-limit 144 --force-grab-cursor --mangoapp -- env LD_PRELOAD="$LD_PRELOAD" %command%
  # You might need this command to re-nice since capSysNice breaks Steam.
  # sudo renice -n -20 -p $(pgrep gamescope-wl)
  programs.gamescope = {
    enable = true;
    capSysNice = false;
    args = [ "--rt" ];
  };

  # Add helper to download custom Proton versions.
  nixfiles.user.packages = [ pkgs.protonup-ng ];
}
