{ pkgs ? import <nixpkgs> { }, is-mac }:

let
  expert-release = if is-mac then
    pkgs.fetchurl {
      url =
        "https://github.com/elixir-lang/expert/releases/download/nightly/expert_darwin_arm64";
      sha256 = "sha256-dSmpByA4XK1dbx7ry3q4KwNwzlwhAYqYDXDOPCmMMTw=";
    }
  else
    pkgs.fetchurl {
      url =
        "https://github.com/elixir-lang/expert/releases/download/nightly/expert_darwin_amd64";
      sha256 = "";
    };

in pkgs.stdenv.mkDerivation {
  name = "expert-lsp";
  src = expert-release;
  phases = [ "installPhase" ];
  installPhase = ''
    ls .
    mkdir -p $out/bin
    cp $src $out/bin/expert-lsp
    chmod +x $out/bin/expert-lsp
  '';
}
