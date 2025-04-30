{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.nixos.gui; in {

  options = {
    nixfiles.nixos.gui = {
      enable = lib.mkEnableOption "GUI Desktop (via Hyprland)";
    };
  };

  config = lib.mkIf cfg.enable {

    # Enable Hyprland.
    programs.hyprland.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    # Enable Graphics.
    services.xserver = {
      enable = true;

      # TODO: Confgiure a more minimal display manager.
      displayManager.gdm = {
        enable = true;
        wayland = true;
        autoSuspend = false;
      };
    };

    environment = {
      # Enable notifications, required by Hyprland.
      systemPackages = with pkgs; [ libnotify ];
      sessionVariables = {
        # Prefer using Ozone because we're under Wayland.
        # Otherwise some Electron apps would start under X-Wayland.
        NIXOS_OZONE_WL = "1";
      };
    };

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
  };
}
