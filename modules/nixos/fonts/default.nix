{ pkgs, ... }: {
  # Configure fonts.
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" "Noto" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono NF" "Noto Color Emoji" ];
        serif = [ "NotoSerif NF" "Noto Color Emoji" ];
        sansSerif = [ "NotoSans NF" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
