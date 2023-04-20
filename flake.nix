{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = w3cli;

          w3cli = pkgs.stdenvNoCC.mkDerivation rec {
            pname = "w3cli";
            version = "3.0.0";
            src = ./.;

            installPhase = ''
              mkdir -p $out/bin
              ln -s ${self}/node_modules/.bin/w3 $out/bin/
              ln -s ${self}/node_modules/.bin/w3up $out/bin/
              ln -s ${self}/node_modules/.bin/w3access $out/bin/
            '';
          };
        };
      }
    );
}
