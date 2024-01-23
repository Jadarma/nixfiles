{ pkgs, config, ... }: {

  # Use GNOME as provided by the default install ISO, to ease initial setup of the rest of the config.
  # TODO: Get rid of this abomination as quickly as possible.
  services.xserver = {
    enable = true;

    desktopManager.gnome = {
      enable = true;

      extraGSettingsOverrides = ''
        [org.gnome.shell]
        welcome-dialog-last-shown-version='9999999999'
        [org.gnome.desktop.session]
        idle-delay=0
        [org.gnome.settings-daemon.plugins.power]
        sleep-inactive-ac-type='nothing'
        sleep-inactive-battery-type='nothing'
      '';
    };

    displayManager.gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };
  };
}
