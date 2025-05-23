{ config, lib, ... }:
let cfg = config.nixfiles.home.cli.eza; in {
  options = {
    nixfiles.home.cli.eza = {
      enable = lib.mkEnableOption "Better LS (Eza)";
    };
  };

  config = lib.mkIf cfg.enable {
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

      initContent = ''
        function lg() {
          REPO=$(git rev-parse --show-toplevel)
          [ -z "$REPO" ] && return 1
          eza -l -a -T --git --git-ignore --group-directories-first --time-style=long-iso --icons --color=always "$REPO" | awk -e '$6 !~ /--|I/ { print }'
        }
      '';
    };
  };
}
