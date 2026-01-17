{ config, lib, ... }:
lib.mkIf config.nixfiles.enable {

  homebrew = {
    enable = true;

    global = {
      autoUpdate = false;
      brewfile = true;
      lockfiles = false;
    };

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs = {
      appdir = "/Applications";
      no_quarantine = true;
      require_sha = true;
    };
  };

  environment.interactiveShellInit = ''
    # Begin Homebrew
    eval $(${config.homebrew.brewPrefix}/brew shellenv)
    alias brew="echo 'Do not use Homebrew manually, manage it via nix-darwin.' && false"
    # End Homebrew

  '';
}
