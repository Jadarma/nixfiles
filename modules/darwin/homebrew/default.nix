{ config, lib, ... }:
let cfg = config.nixfiles.darwin.homebrew; in {

  options = {
    nixfiles.darwin.homebrew = {
      enable = lib.mkEnableOption "Homebrew (Alternate Package Manager)";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;

      onActivation.cleanup = "zap";

      caskArgs = {
        appdir = "~/Applications";
        require_sha = true;
      };
    };

    environment.variables = {
      HOMEBREW_NO_ANALYTICS = "1";
    };
  };
}
