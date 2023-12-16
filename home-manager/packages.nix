{ config, pkgs, ... }:
let
  vars = import ./vars.nix;
  # Rust packages overlay
  fenix = import
    (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz")
    { };
in with pkgs;
let
  macPackages = if vars.isMac then [
    asdf-vm
    erlang_26
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
  # rustComponents = if vars.isMac then
  #   fenix.stable.withComponents [
  #     "cargo"
  #     "clippy"
  #     "rust-src"
  #     "rustc"
  #     "rustfmt"
  #     "rust-analyzer"
  #   ]
  # else
  #   fenix.latest.withComponents [
  #     "cargo"
  #     "clippy"
  #     "rust-src"
  #     "rustc"
  #     "rustfmt"
  #     "rust-analyzer"
  #   ];
  # rustAnalyzer = fenix.latest.rust-analyzer;
  devPackages = [ ];
  basePackages = [
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
    neofetch
    jq
    nixfmt
    git
    vim
    victor-mono
    fira-code
    nil
    jetbrains-mono
    fzf
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
