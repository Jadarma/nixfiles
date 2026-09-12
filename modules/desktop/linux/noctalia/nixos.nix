# Noctalia
# Beautiful and customizable Desktop Shell.
{
  config,
  lib,
  pkgs,
  noctalia,
  ...
}:
{

  imports = [
    noctalia.nixosModules.default
  ];

  config = lib.mkIf config.nixfiles.desktop.enable {

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    # Enable the notification library system-wide.
    environment.systemPackages = with pkgs; [ libnotify ];

    home-manager.users."${config.nixfiles.user.name}".imports = [
      noctalia.homeModules.default
    ];
  };
}
