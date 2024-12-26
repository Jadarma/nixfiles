{ pkgs, ... }: {
  # TODO: Remove after scream works from stable channel.
  nixpkgs.overlays = [
    (self: super: let
      nixpkgs-scream-pin = pkgs.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "de1864217bfa9b5845f465e771e0ecb48b30e02d";
        sha256 = "sha256-Ucfnxq1rF/GjNP3kTL+uTfgdoE9a3fxDftSfeLIS8mA=";
      };
      pkgs-scream-pin = import nixpkgs-scream-pin {
        system = self.system;
        config.allowUnfree = true;
      };
      in {
        scream = pkgs-scream-pin.scream;
      }
    )
  ];
}
