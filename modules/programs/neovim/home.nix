{ osConfig, lib, ... }:
lib.mkIf osConfig.nixfiles.programs.neovim.enable {
  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;

    vimAlias = true;
    vimdiffAlias = true;

    # TODO: State version 26.05 changed this behavior. This is fine, this suppresses warnings for older systems.
    withPython3 = false;
    withRuby = false;
  };
}
