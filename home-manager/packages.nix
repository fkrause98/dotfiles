{ config, pkgs, vars, ... }:
let
  # Rust packages overlay
  fenix = import
    (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz")
    { };
  lsp-booster = import ./lsp-booster.nix { pkgs = pkgs; };
in with pkgs;
let
  macPackages = if vars.isMac then [ ] else [ ];
  linuxPackages = if vars.isLinux then [ xsel flameshot ] else [ ];
  rustUtils = [ bacon mprocs ];
  devPackages = [ nodePackages_latest.typescript-language-server ];
  basePackages = [
    fzf
    lazygit
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
    vim
    victor-mono
    fira-code
    nil
    jetbrains-mono
    fzf
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    difftastic
    cargo-nextest
    nodejs
    pyright
  ];
  # doomEmacsDeps = [
  #   binutils
  #   (ripgrep.override { withPCRE2 = true; })
  #   gnutls
  #   fd
  #   imagemagick
  #   zstd
  #   # nodePackages.javascript-typescript-langserver
  #   # sqlite
  #   editorconfig-core-c
  # ];

in builtins.concatLists [
  # doomEmacsDeps
  basePackages
  macPackages
  linuxPackages
  rustUtils
  devPackages
]
