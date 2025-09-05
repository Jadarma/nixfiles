{ pkgs, ... }: {

  imports = [ ./appleSettings.nix ];

  # System
  system.stateVersion = 5;
  networking = {
    hostName = "JadarmaM4";
    computerName = "Mac Mini M4";
  };

  # Configure user.
  users.users."dan" = {
    description = "Dan Cîmpianu";
    shell = pkgs.zsh;
    home = "/Users/dan";
  };

  home-manager.users.dan = ./home.nix;
  system.primaryUser = "dan";

  nixfiles.darwin = {
    saneDefaults.enable = true;
  };

  homebrew = {
    masApps.Xcode = 497799835;

    casks = [
      { name = "discord"; greedy = true; }
      { name = "ghostty"; greedy = true; }
      { name = "jetbrains-toolbox"; greedy = true; }
      { name = "keepassxc"; greedy = true; }
      { name = "signal"; greedy = true; }
    ];
  };
}
