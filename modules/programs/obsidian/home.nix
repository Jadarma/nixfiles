{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
lib.mkIf osConfig.nixfiles.programs.obsidian.enable {

  # NOTE: Even though HomeManager does have an obsidian module... it's kinda useless for me.
  #       Obsidian does not support holding any common settings under `.config/obsidian`.
  #       As such, only nix-managed vaults will get them, but those would be symlinks to the local /nix/store.
  #       Since I want to not store my vault locally, but rather on an NFS share, it is not compatible with this.
  #       Instead, a default vault config is saved to "$XDG_DATA_HOME/obsidian", so that I may initialize new vaults
  #       with the sane defaults, should I need them.
  #       The most important is the nixfiles theme, which is generated from the Flake theme, of course!
  home.packages = with pkgs; [ obsidian ];

  xdg.dataFile = with config.colorScheme.palette; {

    "obsidian/app.json".text = builtins.toJSON {
      alwaysUpdateLinks = true;
      trashOption = "local";
      settingsPopoutWindow = true;
    };

    "obsidian/appearance.json".text = builtins.toJSON {
      theme = "obsidian";
      accentColor = accent;
      enabledCssSnippets = [ "nixfiles_theme" ];
      baseFontSizeAction = true;
      nativeMenus = false;
      showRibbon = false;
      showViewHeader = true;
    };

    "obsidian/snippets/nixfiles_theme.css".text = ''
      .theme-dark {
      	/* Basic colors. */
      	--color-accent: #${accent};
      	--color-base-00: #${shadow};
      	--color-base-05: #${base00};
      	--color-base-10: #${base00};
      	--color-base-20: #${base01};
      	--color-base-25: #${base01};
      	--color-base-30: #${base02};
      	--color-base-35: #${base02};
      	--color-base-40: #${base03};
      	--color-base-50: #${base03};
      	--color-base-60: #${base04};
      	--color-base-70: #${base04};
      	--color-base-100: #${base05};

      	/* Extended colors */
      	--color-red: #${base08};
      	--color-orange: #${base09};
      	--color-yellow: #${base0A};
      	--color-green: #${base0B};
      	--color-cyan: #${base0C};
      	--color-blue: #${base0D};
      	--color-purple: #${base0E};

      	/* Surface Colors */
      	--background-primary: var(--color-base-20);
      	--background-primary-alt: var(--color-base-10);
      	--background-secondary: var(--color-base-10);
      	--background-secondary-alt: var(--color-base-00);
      	--interactive-normal: var(--background-primary);
      	--interactive-hover: var(--background-primary-alt);
      	--interactive-accent: var(--color-accent);
      	--interactive-accent-hover: var(--color-blue);

      	/* Text Colors */
      	--caret-color: var(--color-accent);
      	--text-selection: color-mix(in srgb, var(--color-accent), transparent 80%);
      	--text-highlight-bg: color-mix(in srgb, var(--color-yellow), transparent 80%);

      	/* Graph */
      	--graph-line: var(--color-base-50);
      	--graph-node-focused: var(--color-accent);
      	--graph-node-tag: var(--color-green);
      	--graph-node-attachment: var(--color-yellow);

      	/* Canvas */
      	--canvas-dot-pattern: var(--color-base-00);
      }
    '';
  };
}
