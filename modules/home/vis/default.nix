{ pkgs, config, lib, osConfig, ... }: {

  # This program is useless unless there is sound.
  config = lib.mkIf (osConfig.sound.enable) {
    home.packages = with pkgs; [ cli-visualizer ];

    xdg.configFile."vis/colors/theme".text = with config.colorScheme.colors; ''
      #${base0E}
      #${base0D}
      #${base0B}
      #${base0A}
      #${base09}
      #${base08}
    '';

    xdg.configFile."vis/config".source = ./config.conf;
  };
}
