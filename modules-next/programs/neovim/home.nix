{ osConfig, lib, ... }:
lib.mkIf osConfig.nixfiles.programs.neovim.enable {
  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;

    vimAlias = true;
    vimdiffAlias = true;
  };
}
