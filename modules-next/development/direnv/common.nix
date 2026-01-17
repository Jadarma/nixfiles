# Direnv
# And Devenv, provide useful development shells for per-project environments.
{ lib, ... }:
{
  options.nixfiles.development.direnv = {
    enable = lib.mkEnableOption "direnv";
  };
}
