{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.development.containers; in {
  options = {
    nixfiles.home.development.containers = {
      enable = lib.mkEnableOption "Containers (Docker-Darwin Workaround)";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      colima
      docker-client
    ];
  };
}
