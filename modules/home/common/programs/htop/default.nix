{ config, lib, ... }:
let cfg = config.nixfiles.home.programs.htop; in {
  options = {
    nixfiles.home.programs.htop = {
      enable = lib.mkEnableOption "Htop (Terminal Task Manager)";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.htop.enable = true;

    # Htop configs done manually because of:
    # - https://github.com/nix-community/home-manager/issues/4947
    # - https://github.com/nix-community/home-manager/issues/3616
    xdg.configFile."htop/htoprc" = {
      source = ./htoprc;
      force = true;
    };
  };
}
