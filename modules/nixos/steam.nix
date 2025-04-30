{ config, lib, ... }:
let cfg = config.nixfiles.nixos.steam; in {

  options = {
    nixfiles.nixos.steam = {
      enable = lib.mkEnableOption "Steam (Gaming)";
      gamescope = lib.mkOption {
        description = "Whether to enable GameScope integration.";
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = cfg.gamescope;
    };

    # Example Steam Launch Options: gamescope -f -w 2560 -h 1440 -r 144 --adaptive-sync --framerate-limit 144 --mangoapp  %command%
    programs.gamescope = {
      enable = cfg.gamescope;
      capSysNice = false; # Value of true breaks, see: https://github.com/NixOS/nixpkgs/issues/351516
      args = [ "--rt" ];
    };
  };
}
