# Mako
# Notification daemon.
{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.desktop.enable {

  # Enable the notification library system-wide.
  environment.systemPackages = with pkgs; [ libnotify ];
}
