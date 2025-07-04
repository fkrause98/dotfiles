{ config, pkgs, ... }:
let
  # Rust packages overlay
  fenix = import
    (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz")
    { };
  lsp-booster = import ./lsp-booster.nix { pkgs = pkgs; };
in with pkgs;
let
  rustUtils = [ bacon mprocs ];
  devPackages =
    [ nodePackages_latest.typescript-language-server nodePackages.prettier ];
  basePackages = [
    lan-mouse
    solc-select
    fzf
    htop
    statix
    ripgrep
    fd
    eza
    bat
    tealdeer
    tmux
    gnumake
    fastfetch
    jq
    nixfmt
    git
    neovim
    victor-mono
    nil
    fzf
    difftastic
    cargo-nextest
    # nodejs
    pyright
    gnupg
  ];
  doomEmacsDeps = [
    binutils
    (ripgrep.override { withPCRE2 = true; })
    gnutls
    fd
    imagemagick
    zstd
    sqlite
    editorconfig-core-c
  ];

in builtins.concatLists [
  # doomEmacsDeps
  basePackages
  rustUtils
  devPackages
]
