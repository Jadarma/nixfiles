{
  description = "Jadarma's NixFiles";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {

    # Scans for NixOS configurations in this flake based on file structure.
    # To register a new system, create a `configuration.nix` file in a directory with its name, under another directory with its architecture, under `./systems`.
    # That configuration will be passed all the flake inputs, and is functionally equivalent to the `/etc/nixos/configuration.nix` on a simple NixOS install.
    # For example:
    # ./systems/x86_64-liunux/playgroundVM/configuration.nix
    nixosConfigurations =
      let
        inherit (builtins) map concatMap filter foldl' readDir attrNames;
        inherit (nixpkgs.lib) filterAttrs mergeAttrs;

        # Read a `path` as a directory, and return a list of the names of all direct subdirectories in it.
        directSubdirectories = path: attrNames (filterAttrs (name: type: type == "directory") (readDir path));

        # Read the directory structure, and return a list of targets, containing architecture and hostname.
        # For example: [ { system = "x86_64-linux"; host = "hostname"; }].
        hostWithSystems = system: map (host: { host = host; system = system; }) (directSubdirectories ./systems/${system});
        configTargets = concatMap hostWithSystems (directSubdirectories ./systems);

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

    # Creates a devshell for working with this flake via direnv.
    # Set the `supportedSystems` to be the set of system architectures you target, all others would be a bit redundant, no?
    devShells =
      let
        supportedSystems = [ "x86_64-linux" ];
        forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
          pkgs = import nixpkgs { inherit system; };
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
          ];
        };
      });
  };
}
