{ pkgs, ... }: {
  # Set ZSH as the default shell.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
