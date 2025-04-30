{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.nixos.sound; in {

  options = {
    nixfiles.nixos.sound = {
      enable = lib.mkEnableOption "Sound And Audio (via Pipewire)";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable pulseaudio API.
    environment.systemPackages = with pkgs; [ pulseaudio ];
  };
}
