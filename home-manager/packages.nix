{ config, pkgs, ... }:
let
  vars = import ./vars.nix;
  # Rust packages overlay
  fenix = import
    (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz")
    { };
  lsp-booster = import ./lsp-booster.nix { pkgs = pkgs; };
in with pkgs;
let
  macPackages = if vars.isMac then [
    asdf-vm
    wxGTK32
    elixir-ls
    iterm2
    ngrok
    protobuf
    libiconv
    # omnisharp-roslyn
    # dotnet-sdk_7
    rustup
  ] else
    [ ];
  linuxPackages = if vars.isLinux then [ xsel emacs29 ] else [ ];
  rustUtils = [ bacon mprocs ];
  devPackages = [ ];
  basePackages = [
    lsp-booster
    lazygit
    flameshot
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
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono"]; })
    difftastic
    cargo-nextest
    nodejs
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
]
