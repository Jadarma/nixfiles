{ config, lib, ... }:
lib.mkIf config.nixfiles.programs.ghostty.enable {
  homebrew.casks = [
    {
      name = "ghostty";
      greedy = true;
    }
  ];
}
