# Audio
# Enable sound via pipewire and useful utilities.
{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.desktop.enable {

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable pulseaudio API.
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    qpwgraph
  ];
}
