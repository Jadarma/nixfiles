{ ... }: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # gamescope -f -w 2560 -h 1440 -r 144 --adaptive-sync --framerate-limit 144  --mangoapp  %command%
  programs.gamescope = {
    enable = true;
    # Breaks Steam, see:
    # - https://github.com/NixOS/nixpkgs/issues/208936
    # - https://discourse.nixos.org/t/unable-to-activate-gamescope-capsysnice-option/37843/12
    capSysNice = false;
    args = [ "--rt" ];
  };
}
