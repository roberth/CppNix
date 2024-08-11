{ stdenv, ... }:
stdenv.mkDerivation {
  name = "cppnix";
  src = ./src;
  buildPhase = ''
    patchShebangs --host cc1.sh
  '';
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/nix-support
    cp cc1.sh $out/bin/cc1
    chmod a+x $out/bin/cc1
    substitute cppnix-setup.sh $out/nix-support/setup-hook --subst-var out
    runHook postInstall
  '';
}