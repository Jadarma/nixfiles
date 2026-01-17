# Containers
# Offers virtualization environments for OCI images.
{ lib, ... }:
{
  options.nixfiles.development.containers = {
    enable = lib.mkEnableOption "OCI Containers";
  };
}
