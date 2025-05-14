{ config, lib, ... }:
let cfg = config.nixfiles.home.cli.ripgrep; in {
  options = {
    nixfiles.home.cli.ripgrep = {
      enable = lib.mkEnableOption "Better Grep (Ripgrep)";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;

      arguments = [
        # Appearance
        "--color=auto"
        "--colors=path:fg:magenta"
        "--colors=line:fg:cyan"
        "--colors=column:fg:cyan"
        "--colors=match:fg:red"
        "--colors=match:style:underline"

        # Behavior
        "--smart-case"
        "--crlf"
        "--no-require-git"
        "--max-columns-preview"
      ];
    };
  };
}
