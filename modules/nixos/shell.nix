{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.nixos.shell; in {

  options = {
    nixfiles.nixos.shell = {
      enable = lib.mkEnableOption "Zsh (Default System Shell)";
    };
  };

  config = lib.mkIf cfg.enable {
    # Set ZSH as the default shell.
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
}
