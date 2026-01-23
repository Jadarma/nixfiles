{ osConfig, lib, ... }:
lib.mkIf osConfig.nixfiles.programs.ripgrep.enable {
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
}
