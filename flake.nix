{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";

    w3cli_src.url = "github:web3-storage/w3cli?ref=v3.0.0";
    w3cli_src.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, w3cli_src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = w3cli;

          w3cli = pkgs.buildNpmPackage rec {
            pname = "w3cli";
            version = "3.0.0";
            src = w3cli_src;

            npmDepsHash = "sha256-koDF5zhkoQg7oA+0PtH4O/N0ptNYtzxhCsfbmxcZCjk=";
            dontNpmBuild = true;
          };
        };
      }
    );
}
