{ config, lib, ... }:
let
  weekly = {
    Hour = 0;
    Minute = 0;
    Weekday = 0;
  };
in
lib.mkIf config.nixfiles.enable {

  # Make administrators trusted users.
  nix.settings.trusted-users = [ "@admin" ];

  # Configure weekly automatic store optimisation jobs.
  nix.gc.interval = weekly;
  nix.optimise.interval = weekly;
}
