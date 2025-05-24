{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.nixos.sound; in {

  options = {
    nixfiles.nixos.sound = {
      enable = lib.mkEnableOption "Sound And Audio (via Pipewire)";
    };
  };

  config = lib.mkIf cfg.enable {
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
    environment.systemPackages = with pkgs;
      [ pulseaudio ]
      ++ (lib.optionals config.nixfiles.nixos.gui.enable [ pavucontrol qpwgraph ]);
  };
}
