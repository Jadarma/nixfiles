{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.development.jetbrains.idea.enable {
  # On Linux we pull the dependency directly, because we need the Nix-patched one.
  users.users."${config.nixfiles.user.name}".packages = with pkgs; [
    idea-ultimate
  ];
}
