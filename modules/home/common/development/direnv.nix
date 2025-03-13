{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.development.direnv; in {
  options = {
    nixfiles.home.development.direnv = {
      enable = lib.mkEnableOption "Direnv & Devenv";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    home.packages = with pkgs; [ devenv ];
  };
}
