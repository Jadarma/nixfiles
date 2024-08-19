{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
      git-crypt
      jetbrains.idea-ultimate
    ];
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
