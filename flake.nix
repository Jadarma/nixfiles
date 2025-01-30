{
  description = "Jadarma's NixFiles";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    homeManager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
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

  outputs = inputs@{ self, nixpkgs, nix-darwin, ... }:
    let
      inherit (builtins) map concatMap filter foldl' readDir attrNames;
      inherit (nixpkgs.lib) filterAttrs mergeAttrs strings;

      # Read a `path` as a directory, and return a list of the names of all direct subdirectories in it.
      directSubdirectories = path: attrNames (filterAttrs (name: type: type == "directory") (readDir path));

      # Read the directory structure, and return a list of targets, containing architecture and hostname.
      # For example: [ { system = "x86_64-linux"; host = "hostname"; }].
      hostWithSystems = system: map (host: { host = host; system = system; }) (directSubdirectories ./systems/${system});
    in
    {
      # Scans for NixOS configurations in this flake based on file structure.
      # To register a new system, create a `configuration.nix` file in a directory with its name, under another directory with its architecture, under `./systems`.
      # That configuration will be passed all the flake inputs, and is functionally equivalent to the `/etc/nixos/configuration.nix` on a simple NixOS install.
      # For example:
      # ./systems/x86_64-linux/playgroundVM/configuration.nix
      nixosConfigurations =
        let
          # Detect NixOS systems.
          configTargets = concatMap hostWithSystems (filter (strings.hasSuffix "-linux") (directSubdirectories ./systems));

          # From a host name and a system architecture, create a NixOS system, which passes all flake inputs to the `configuration.nix` of the target.
          mkNixosSystem = { host, system }: {
            "${host}" = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = inputs // { nixfiles = ./.; };
              modules = [ ./systems/${system}/${host}/configuration.nix ];
            };
          };
        in
        foldl' mergeAttrs { } (map mkNixosSystem configTargets);

      darwinConfigurations =
        let
          # Detect NixDarwin systems.
          configTargets = concatMap hostWithSystems (filter (strings.hasSuffix "-darwin") (directSubdirectories ./systems));

          # From a host name and a system architecture, create a NixDarwin system, which passes all flake inputs to the `configuration.nix` of the target.
          mkNixDarwinSystem = { host, system }: {
            "${host}" = nix-darwin.lib.darwinSystem {
              specialArgs = inputs // { nixfiles = ./.; };
              modules = [
                { system.configurationRevision = self.rev or self.dirtyRev or null; }
                { nixpkgs.hostPlatform = system; }
                ./systems/${system}/${host}/configuration.nix
              ];
            };
          };
        in
        foldl' mergeAttrs { } (map mkNixDarwinSystem configTargets);

      # Creates a devshell for working with this flake via direnv.
      # Set the `supportedSystems` to be the set of system architectures you target, all others would be a bit redundant, no?
      devShells =
        let
          supportedSystems = [ "x86_64-linux" "aarch64-darwin" ];
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
                  equinusocio.vsc-material-theme
                  equinusocio.vsc-material-theme-icons
                  jnoortheen.nix-ide
                  mkhl.direnv
                  timonwong.shellcheck
                ];
              })
              python312Packages.mkdocs-material
              (python312Packages.buildPythonPackage rec {
                pname = "markdown_callouts";
                version = "0.4.0";
                pyproject = true;

                src = fetchPypi {
                  inherit pname version;
                  sha256 = "sha256-ftLJBIaWcFinOlR3gRIZg4OVItZwQa5SxJeWFvGyt0Y=";
                };

                nativeBuildInputs = with python312Packages; [ setuptools hatchling markdown ];
                pythonImportsCheck = [ "markdown_callouts" ];
              })
            ];
          };
        });
    };
}
