{ osConfig, lib, ... }:
lib.mkIf osConfig.nixfiles.programs.htop.enable {
  programs.htop.enable = true;

  # TODO: Htop configs were manually because of these (but have since been fixed and can be nix-ified!):
  # - https://github.com/nix-community/home-manager/issues/4947
  # - https://github.com/nix-community/home-manager/issues/3616
  xdg.configFile."htop/htoprc" = {
    source = ./htoprc;
    force = true;
  };
}
