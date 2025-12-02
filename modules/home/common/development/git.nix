{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.development.git; in {
  options = {
    nixfiles.home.development.git = {
      enable = lib.mkEnableOption "Git";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Jadarma";
          email = "dancristiancimpianu@gmail.com";
        };
        extraConfig = {
          credential.helper = "cache";
          init.defaultBranch = "main";
        };
      };

      # Sign commits by default.
      # Actual key should be provided by GPG module, or signing disabled with `git config --local` per project.
      signing = {
        key = "64A2168E274BF8AF";
        signByDefault = true;
      };
    };

    home.packages = with pkgs; [ git-crypt ];
  };
}
