{
  osConfig,
  lib,
  pkgs,
  ...
}:
lib.mkIf osConfig.nixfiles.development.direnv.enable {

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [ devenv ];
}
