{
  description = "A Nix extension for the C preprocessor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }: {
        systems = [ "x86_64-linux" ];
        perSystem = { config, pkgs, ... }:
        {
          packages.cppnix = pkgs.callPackage ./package.nix { };
          packages.default = config.packages.cppnix;

          packages.example = pkgs.callPackage ./example/package.nix { inherit (config.packages) cppnix; };
          checks.example = pkgs.callPackage ./example/check.nix { inherit (config.packages) example; };

          devShells.default = pkgs.stdenv.mkDerivation {
            name = "dev-shell";
          };
          devShells.example = config.packages.example;
        };
      });
}
