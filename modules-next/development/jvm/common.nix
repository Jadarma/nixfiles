# JVM
# Configures Java for the system.
{ lib, pkgs, ... }:
{
  options.nixfiles.development.jvm = {
    enable = lib.mkEnableOption "Bat";

    package = lib.mkPackageOption pkgs "jdk" {
      default = "jdk21";
    };
  };
}
