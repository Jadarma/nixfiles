{ config, lib, ... }: {
  xdg = let home = config.home.homeDirectory; in {
    enable = true;

    configHome = lib.mkDefault "${home}/.config";
    dataHome = lib.mkDefault "${home}/.local/share";
    cacheHome = lib.mkDefault "${home}/.cache";
    stateHome = lib.mkDefault "${home}/.local/state";
  };
}
