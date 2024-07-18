{ pkgs, config, ... }: {

  home.packages = with pkgs; [
    jetbrains-toolbox
    git-crypt
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
