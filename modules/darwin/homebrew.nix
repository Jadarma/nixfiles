{ config, lib, ... }:
let
  cfg = config.nixfiles.darwin.homebrew;
  shellInit = ''
    # Begin Homebrew
    eval $(${config.homebrew.brewPrefix}/brew shellenv)
    alias brew="echo 'Do not use Homebrew manually, manage it via nix-darwin.' && false"
    # End Homebrew
  '';
in
{
  options = {
    nixfiles.darwin.homebrew = {
      enable = lib.mkEnableOption "Homebrew (Alternate Package Manager)";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;

      global = {
        autoUpdate = false;
        brewfile = true;
        lockfiles = false;
      };

      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };

      caskArgs = {
        appdir = "/Applications";
        no_quarantine = true;
        require_sha = true;
      };
    };

    environment = {
      etc = {
        "bash.local".text = shellInit;
        "zshrc.local".text = shellInit;
      };

      variables = {
        HOMEBREW_NO_ANALYTICS = "1";
      };
    };
  };
}
