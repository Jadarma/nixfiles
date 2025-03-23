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

    home.shellAliases = {
      # Convenience to symlink colima as the default docker sock for programs that hardcode the path.
      "colima-link" = ''sudo ln -s "$XDG_CONFIG_HOME/colima/default/docker.sock" /var/run/docker.sock'';
    };
  };
}
