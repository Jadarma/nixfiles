{ pkgs, ... }: {

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    enableZshIntegration = true;
  };

  home.packages = with pkgs; [ devenv ];
}
