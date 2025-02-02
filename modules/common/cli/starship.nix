{ config, lib, ... }:
let cfg = config.nixfiles.common.cli; in {
  options = {
    nixfiles.common.cli.starship = {
      enable = lib.mkEnableOption "Starship Shell Prompt";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.starship.enable) {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = false;
        scan_timeout = 10;
        format = builtins.replaceStrings [ "\n" ] [ "" ] ''
          $username
          $hostname
          $directory
          $git_branch
          $git_commit
          $git_state
          $git_status
          $cmd_duration
          $jobs
          $status
          $character
        '';

        username.style_user = "bold cyan";

        directory = {
          format = "[$read_only]($read_only_style)[$path]($style) ";
          style = "yellow";
          truncation_length = 4;
          truncation_symbol = "…/";
          read_only = "🔒";
        };

        cmd_duration.style = "bold blue";

        jobs.symbol = "⧗";

        status = {
          format = "[$status]($style)";
          style = "bold red";
          disabled = false;
        };
      };
    };
  };
}
