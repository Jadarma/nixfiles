# Locale
# Configures some locale fallbacks. They are mostly made for me, so they use mkDefault to not clash with declaring them
# normally on a different host or user setup.
{ config, lib, ... }: lib.mkIf config.nixfiles.enable {
  # Set the timezone.
  time.timeZone = lib.mkDefault "Europe/Bucharest";

  # Set sensible defaults for i18n.
  # Using en_DK because it formats dates in ISO-8601.
  i18n = lib.mkDefault {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_DK.UTF-8";
      LC_IDENTIFICATION = "en_DK.UTF-8";
      LC_MEASUREMENT = "en_DK.UTF-8";
      LC_MONETARY = "en_DK.UTF-8";
      LC_NAME = "en_DK.UTF-8";
      LC_NUMERIC = "en_DK.UTF-8";
      LC_PAPER = "en_DK.UTF-8";
      LC_TELEPHONE = "en_DK.UTF-8";
      LC_TIME = "en_DK.UTF-8";
    };
  };

  # Set keyboard layout.
  # NOTE: This is a system default, Hyprland will take over.
  services.xserver.xkb = lib.mkDefault {
    layout = "ro";
    variant = "";
    model = "pc104";
  };
}
