{ config, lib, ... }:
let cfg = config.nixfiles.common.cli; in {
  options = {
    nixfiles.common.cli.eza = {
      enable = lib.mkEnableOption "Better LS (Eza)";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.eza.enable) {
    programs.eza = {
      enable = true;
    };

    programs.zsh = {
      sessionVariables.EZA_COLORS = "da=2";

      shellAliases = {
        l = "eza";
        la = "eza -a";
        ll = "eza -l --group-directories-first --time-style=long-iso --icons";
        lla = "ll -a";
        lt = ''ll -T --git-ignore'';
        lta = "lt -a";
      };

      initExtra = ''
        function lg() {
          REPO=$(git rev-parse --show-toplevel)
          [ -z "$REPO" ] && return 1
          eza -l -a -T --git --git-ignore --group-directories-first --time-style=long-iso --icons --color=always "$REPO" | awk -e '$6 !~ /--|I/ { print }'
        }
      '';
    };
  };
}
