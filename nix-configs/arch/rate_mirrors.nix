{ pkgs ? import <nixpkgs> { } }:
let
  rate-mirrors = builtins.fetchTarball {
    url =
      "https://github.com/westandskif/rate-mirrors/releases/download/v0.15.0/rate-mirrors-v0.15.0-x86_64-unknown-linux-musl.tar.gz";
    sha256 = "1rhkyrv4nn2yql07ldsv8bhwmib4p0778yrz6hdrwqy2x57h3jky";
  };
in pkgs.stdenv.mkDerivation {
  name = "rate-mirrors";
  src = rate-mirrors;
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/rate_mirrors $out/bin/rate_mirrors
    chmod +x $out/bin/rate_mirrors
  '';
}
