{ pkgs ? import <nixpkgs> { } }:
let
  lsp-booster = pkgs.fetchzip {
    url =
      "https://github.com/blahgeek/emacs-lsp-booster/releases/download/v0.2.1/emacs-lsp-booster_v0.2.1_x86_64-apple-darwin.zip";
    sha256 = "sha256-oQfBKqA3fa1f/roRTXITikj6L4LG0wycBepUVVGUWgc";
  };
in pkgs.stdenv.mkDerivation {
  name = "emacs-lsp-booster";
  src = lsp-booster;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/emacs-lsp-booster $out/bin/emacs-lsp-booster
    chmod +x $out/bin/emacs-lsp-booster
  '';
}
