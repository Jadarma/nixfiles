# Neovim
# Sets neovim as the default vim replacement and CLI editor.
{ lib, ... }:
{
  options.nixfiles.programs.neovim = {
    enable = lib.mkEnableOption "Neovim";
  };
}
