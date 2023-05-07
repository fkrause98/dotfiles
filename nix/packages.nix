{ config, pkgs, ... }:
let vars = import ./vars.nix;
in with pkgs;
let
  macPackages = if vars.isMac then [ elixir-ls iterm2 ngrok ] else [ ];
  archPackages = if vars.isLinux then
    [ (pkgs.callPackage ./arch/rate_mirrors.nix { inherit pkgs; }) ]
  else
    [ ];
  devPackages = [ asdf-vm rustup ];
  basePackages = [
    ripgrep
    fd
    ea
    bat
    tmux
    direnv
    gnumake
    neofetch
    jq
    nixfmt
    git
    vim
    victor-mono
    fira-code
    nil
  ];
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
  ];

in builtins.concatLists [ doomEmacsDeps devPackages basePackages archPackages ]
