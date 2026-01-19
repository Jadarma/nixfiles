{ ... }:
{

  imports = [ ./appleSettings.nix ];

  # Nixfiles
  nixfiles = {
    enable = true;

    user = {
      name = "dan";
      displayName = "Dan Cîmpianu";
      homeDirectory = "/Users/dan";
      uid = 501;
      gid = 501;
    };

    development = {
      enable = true;
      containers.enable = true;
      jetbrains.idea.enable = true;
      jetbrains.android.enable = true;
    };

    programs = {
      defaultCli.enable = true;
      defaultGui.enable = true;
    };

    state = {
      homeManager = "25.11";
      system = 6;
    };
  };

  # System
  networking = {
    hostName = "JadarmaM4";
    computerName = "Mac Mini M4";
  };

  # Extra programs.
  homebrew.casks = [
    {
      name = "discord";
      greedy = true;
    }
    {
      name = "keepassxc";
      greedy = true;
    }
    {
      name = "signal";
      greedy = true;
    }
  ];
}
