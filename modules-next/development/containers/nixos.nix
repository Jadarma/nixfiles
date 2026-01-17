{ config, lib, ... }:
lib.mkIf config.nixfiles.development.containers.enable {

  # Enable Docker for a runtime. Might consider Podman in future.
  virtualisation.docker.enable = true;

  # Add the user to the docker group so it may access the socket.
  users.groups.docker.members = [ config.nixfiles.user.name ];
}
