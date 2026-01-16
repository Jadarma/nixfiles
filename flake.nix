{
  description = "Jadarma's NixFiles";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  # System configuration outputs in this flake are based on file structure.
  # To register a new system, create a `configuration.nix` file in a directory with its name, under another directory
  # with its architecture, under `./systems`.
  # That configuration will be passed all the flake inputs, and is functionally equivalent to the
  # `/etc/nixos/configuration.nix` on a simple NixOS install.
  # For example:
  # ./systems/x86_64-linux/JadarmaPC/configuration.nix
  # ./systems/aarch64-darwin/JadarmaM4/configuration.nix
  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, nix-colors, mac-app-util, ... }:
    let
      inherit (builtins) map concatMap filter foldl' readDir attrNames;
      inherit (nixpkgs.lib) filterAttrs mergeAttrs strings;

      # Read a `path` as a directory, and return a list of the names of all direct subdirectories in it.
      directSubdirectories = path: attrNames (filterAttrs (name: type: type == "directory") (readDir path));

      # The list of supported system architectures, derived from existing configurations in the file structure.
      supportedSystems = directSubdirectories ./systems;

      # Read the directory structure, and return a list of targets, containing architecture and hostname.
      # For example: [ { system = "x86_64-linux"; host = "hostname"; }].
      hostWithSystems = system: map (host: { host = host; system = system; }) (directSubdirectories ./systems/${system});

      # Detect all NixOS configurations.
      nixosSystems = concatMap hostWithSystems (filter (strings.hasSuffix "-linux") supportedSystems);

      # Detect all Nix-Darwin configurations.
      darwinSystems = concatMap hostWithSystems (filter (strings.hasSuffix "-darwin") supportedSystems);

      # From a host name and a system architecture, create a NixOS system, which passes all flake inputs to the
      # `configuration.nix` of the target.
      mkNixosSystem = { host, system }: {
        "${host}" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./systems/${system}/${host}/configuration.nix
            ./modules/nixos
            home-manager.nixosModules.home-manager
            {
              system.configurationRevision = self.rev or self.dirtyRev or null;
              nix.settings.experimental-features = "nix-command flakes";
              nixpkgs.hostPlatform = system;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                nix-colors.homeManagerModules.default
                ./modules/home/nixos
              ];
            }
          ];
        };
      };

      # From a host name and a system architecture, create a NixDarwin system, which passes all flake inputs to the
      # `configuration.nix` of the target.
      mkNixDarwinSystem = { host, system }: {
        "${host}" = nix-darwin.lib.darwinSystem {
          specialArgs = inputs;
          modules = [
            ./systems/${system}/${host}/configuration.nix
            ./modules/darwin
            home-manager.darwinModules.home-manager
            {
              system.configurationRevision = self.rev or self.dirtyRev or null;
              nix.settings.experimental-features = "nix-command flakes";
              nixpkgs.hostPlatform = system;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
                nix-colors.homeManagerModules.default
                ./modules/home/darwin
              ];
            }
          ];
        };
      };
    in
    {
      nixosConfigurations = foldl' mergeAttrs { } (map mkNixosSystem nixosSystems);
      darwinConfigurations = foldl' mergeAttrs { } (map mkNixDarwinSystem darwinSystems);

      # Creates a devshell for working with this flake via direnv.
      devShells =
        let
          forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          });
        in
        forEachSupportedSystem ({ pkgs }: {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nixpkgs-fmt
              nixd
              just
              (vscode-with-extensions.override {
                vscode = vscodium;
                vscodeExtensions = with vscode-extensions; [
                  tobiasalthoff.atom-material-theme
                  vscode-icons-team.vscode-icons
                  jnoortheen.nix-ide
                  mkhl.direnv
                  timonwong.shellcheck
                ];
              })
            ];
          };
        });
    };
}
