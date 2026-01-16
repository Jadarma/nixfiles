{
  config,
  osConfig,
  lib,
  ...
}:
lib.mkIf osConfig.nixfiles.enable {

  programs.zsh = {
    enable = true;

    dotDir = "${config.xdg.configHome}/zsh";

    enableCompletion = true;

    history = {
      size = 50000;
      save = 10000;
      path = "${config.xdg.cacheHome}/zsh/zsh_history";
      share = true;
      expireDuplicatesFirst = true;
    };

    # Enable syntax highlighting.
    # Actual colors will use whatever the terminal theme is set to.
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
      ];
      styles = {
        "alias" = "fg=blue";
        "reserved-word" = "fg=magenta";
        "builtin" = "fg=blue";
        "function" = "fg=blue";
        "command" = "fg=blue";
        "precommand" = "fg=blue";
        "commandseparator" = "fg=magenta";
        "back-quoted-argument-unclosed" = "fg=red";
        "back-quoted-argument-delimiter" = "fg=blue";
        "single-quoted-argument" = "fg=green";
        "single-quoted-argument-unclosed" = "fg=red";
        "double-quoted-argument" = "fg=green";
        "double-quoted-argument-unclosed" = "fg=red";
        "dollar-quoted-argument" = "fg=green";
        "dollar-quoted-argument-unclosed" = "fg=red";
        "redirection" = "fg=magenta";
        "process-substitution" = "fg=magenta";
        "command-substitution-delimiter-unquoted" = "fg=yellow";
        "bracket-level-1" = "fg-cyan";
      };
    };
  };
}
