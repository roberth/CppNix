{ stdenv, cppnix, nix }:

stdenv.mkDerivation {
  name = "example";
  src = ./src;
  strictDeps = true;
  nativeBuildInputs = [ cppnix nix ];
  GREETING = "hello";
  installPhase = ''
    mkdir -p $out/bin
    cp example $out/bin
  '';
}