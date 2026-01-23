{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  # On Darwin, use Colima as a Docker provider.
  onDarwin = lib.mkIf pkgs.stdenv.isDarwin {
    home.packages = with pkgs; [
      colima
      docker-client
    ];

    home.shellAliases = {
      # Convenience to symlink colima as the default docker sock for programs that hardcode the path.
      "colima-link" = ''sudo ln -s "$XDG_CONFIG_HOME/colima/default/docker.sock" /var/run/docker.sock'';
    };
  };
in
lib.mkIf osConfig.nixfiles.development.containers.enable (
  lib.mkMerge [
    onDarwin
  ]
)
