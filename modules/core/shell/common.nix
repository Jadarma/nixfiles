# Shell
# Configures ZSH as the base shell of the user.
{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.enable {

  # Configure ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  # Set ZSH as the user's shell.
  users.users."${config.nixfiles.user.name}".shell = pkgs.zsh;
}
