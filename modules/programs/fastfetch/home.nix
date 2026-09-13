{ osConfig, lib, ... }:
lib.mkIf osConfig.nixfiles.programs.fastfetch.enable {

  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = ./logo.txt;
        color = {
          "1" = "blue";
          "2" = "cyan";
          "3" = "blue";
          "4" = "cyan";
          "5" = "blue";
          "6" = "cyan";
        };
      };

      display = {
        color = {
          title = "blue";
          keys = "cyan";
          separator = "black";
          output = "white";
        };
        separator = ": ";
        key.type = "both";
      };

      modules = [
        "title"
        "break"
        {
          type = "os";
          key = "NIX";
          keyIcon = "";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "KER";
          keyIcon = "";
          keyColor = "green";
        }
        {
          type = "uptime";
          key = "UPT";
          keyIcon = "󰔛";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "PKG";
          keyIcon = "󰏗";
          keyColor = "blue";
        }
        {
          type = "cpu";
          key = "CPU";
          keyIcon = "";
          keyColor = "magenta";
        }
        {
          type = "gpu";
          key = "GPU";
          keyIcon = "";
          keyColor = "cyan";
        }
        {
          type = "memory";
          key = "MEM";
          keyIcon = "";
          keyColor = "white";
        }
        {
          type = "disk";
          key = "SSD";
          keyIcon = "󰋊";
          keyColor = "black";
          showExternal = false;
        }
        "break"
        {
          type = "colors";
          brightness = "normal";
          symbol = "block";
        }
      ];
    };
  };
}
