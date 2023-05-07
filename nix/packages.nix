{ config, pkgs, ... }:
let vars = import ./vars.nix;
in with pkgs;
let
  macPackages = if vars.isMac then [ elixir-ls iterm2 ] else [ ];
  devPackages = [ asdf-vm rustup ];
  basePackages =
    [ ripgrep fd ea bat tmux direnv gnumake neofetch jq nixfmt git vim ];
  doomEmacsDeps = [
    binutils
    (ripgrep.override { withPCRE2 = true; })
    gnutls
    fd
    imagemagick
    zstd
    nodePackages.javascript-typescript-langserver
    sqlite
    editorconfig-core-c
    ngrok
  ];
in builtins.concatLists [ doomEmacsDeps devPackages basePackages ]
