{ pkgs, ... }:
{
  # Install the Hyprcursor package system-wide.
  environment.systemPackages = with pkgs; [ hyprcursor ];
}
