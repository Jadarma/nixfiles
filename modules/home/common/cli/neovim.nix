{ config, lib, ... }:
let cfg = config.nixfiles.home.cli.neovim; in {
  options = {
    nixfiles.home.cli.neovim = {
      enable = lib.mkEnableOption "CLI Text Editor (Neovim)";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = lib.mkDefault true;

      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
