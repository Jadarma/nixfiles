{ pkgs, nixfiles, homeManager, nix-colors, mac-app-util, ... }: {

  imports = [
    homeManager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit nixfiles; };
      home-manager.sharedModules = [
        mac-app-util.homeManagerModules.default
        nix-colors.homeManagerModules.default
      ];
      home-manager.users.dan = ./home.nix;
    }
    ./appleSettings.nix
  ];

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

  nixfiles.darwin = {
    saneDefaults.enable = true;
  };

  # More Apps
  environment.systemPackages = with pkgs; [
    neovim
  ];

  homebrew = {
    masApps.Xcode = 497799835;

    casks = [
      { name = "jetbrains-toolbox"; greedy = true; }
      { name = "keepassxc"; greedy = true; }
      { name = "firefox"; greedy = true; }
    ];
  };
}
