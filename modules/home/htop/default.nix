{ ... }: {

  programs.htop.enable = true;

  # Htop configs done manually because of:
  # - https://github.com/nix-community/home-manager/issues/4947
  # - https://github.com/nix-community/home-manager/issues/3616
  xdg.configFile."htop/htoprc" = {
    source = ./htoprc;
    force = true;
  };
}
