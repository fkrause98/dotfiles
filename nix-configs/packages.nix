{ pkgs, ... }:
let lsp-booster = import ./lsp-booster.nix { pkgs = pkgs; };
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
    cmake
    # nodejs
    nodejs
    pyright
    gnupg
    nerd-fonts.fira-code
    nerd-fonts.ubuntu-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.hurmit
    nerd-fonts._0xproto
    lsp-booster
    clang
  ];
  doomEmacsDeps = [
    (ripgrep.override { withPCRE2 = true; })
    gnutls
    fd
    imagemagick
    zstd
    sqlite
  ];

in builtins.concatLists [ doomEmacsDeps basePackages rustUtils devPackages ]
