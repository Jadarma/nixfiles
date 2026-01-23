{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.gaming.steam.enable {

  # Enable Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Example Steam Launch Options: gamescope -f -w 2560 -h 1440 -r 144 --adaptive-sync --framerate-limit 144 --mangoapp  %command%
  programs.gamescope = {
    enable = true;
    capSysNice = false; # Value of true breaks, see: https://github.com/NixOS/nixpkgs/issues/351516
    args = [ "--rt" ];
  };

  # Add helper to download custom Proton versions.
  environment.systemPackages = [ pkgs.protonup-ng ];
}
