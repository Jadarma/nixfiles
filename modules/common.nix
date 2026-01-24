# Common
# Imports all Nixfiles modules relevant for all systems, and define the actual options of the `nixfiles` module.
{
  config,
  lib,
  nix-colors,
  ...
}:
{
  # A hardcoded list of all modules that should be imported on either platform.
  # TODO: Automate by recursively iterating and finding all common.nix files.
  imports = [
    ./core/fonts/common.nix
    ./core/nix/common.nix
    ./core/shell/common.nix
    ./core/user/common.nix
    ./core/state/common.nix
    ./desktop/common.nix
    ./development/common.nix
    ./development/containers/common.nix
    ./development/direnv/common.nix
    ./development/git/common.nix
    ./development/gpg/common.nix
    ./development/jetbrains/android/common.nix
    ./development/jetbrains/idea/common.nix
    ./development/jvm/common.nix
    ./development/nixfiles/common.nix
    ./programs/common.nix
    ./programs/bat/common.nix
    ./programs/cava/common.nix
    ./programs/eza/common.nix
    ./programs/firefox/common.nix
    ./programs/ghostty/common.nix
    ./programs/htop/common.nix
    ./programs/neofetch/common.nix
    ./programs/neovim/common.nix
    ./programs/qalculate/common.nix
    ./programs/ripgrep/common.nix
    ./programs/starship/common.nix
    ./programs/steam/common.nix
    ./programs/zathura/common.nix
    ./services/homelab/common.nix
  ];

  options = {
    nixfiles = {
      enable = lib.mkEnableOption "Whether to enable the Nixfiles module.";
    };
  };

  config = lib.mkIf config.nixfiles.enable {
    # Configure Home Manager.
    home-manager = {
      # Ensure packages between HomeManager and the system are in sync.
      useGlobalPkgs = lib.mkForce true;

      # Allow adding user packages from home.nix.
      useUserPackages = lib.mkForce true;

      # Import dependencies for external inputs.
      sharedModules = [
        nix-colors.homeManagerModules.default
      ];

      # A hardcoded list of all modules that should be imported for Home Manager.
      # TODO: Automate by recursively iterating and finding all home.nix files.
      users."${config.nixfiles.user.name}".imports = [
        ./core/shell/home.nix
        ./core/theme/home.nix
        ./core/xdg/home.nix
        ./desktop/linux/hyprland/home.nix
        ./desktop/linux/mako/home.nix
        ./desktop/linux/scripts/home.nix
        ./desktop/linux/theme/home.nix
        ./desktop/linux/wofi/home.nix
        ./desktop/linux/waybar/home.nix
        ./development/containers/home.nix
        ./development/direnv/home.nix
        ./development/git/home.nix
        ./development/gpg/home.nix
        ./development/jetbrains/android/home.nix
        ./development/jvm/home.nix
        ./development/nixfiles/home.nix
        ./programs/bat/home.nix
        ./programs/cava/home.nix
        ./programs/eza/home.nix
        ./programs/firefox/home.nix
        ./programs/ghostty/home.nix
        ./programs/htop/home.nix
        ./programs/neofetch/home.nix
        ./programs/neovim/home.nix
        ./programs/qalculate/home.nix
        ./programs/ripgrep/home.nix
        ./programs/starship/home.nix
        ./programs/steam/home.nix
        ./programs/zathura/home.nix
      ];
    };
  };
}
