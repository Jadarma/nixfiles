{ config, lib, ... }:
lib.mkIf config.nixfiles.enable {
  # Enable fontconfig for better compatibility wtih applications.
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "JetBrainsMono NF"
        "Noto Color Emoji"
      ];
      serif = [
        "NotoSerif NF"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "NotoSans NF"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
