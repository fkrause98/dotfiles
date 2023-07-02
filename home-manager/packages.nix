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
    elixir-ls
    iterm2
    ngrok
    protobuf
    libiconv
    omnisharp-roslyn
    # TODO: Use emacs-mac port when this
    # issue is closed!
    # https://github.com/NixOS/nixpkgs/issues/127902
    #emacsMacPort
    dotnet-sdk_7
  ] else
    [ ];
  linuxPackages = if vars.isLinux then [ xsel emacs ] else [ ];
  rustUtils = [ bacon mprocs ];
  rustComponents = if vars.isMac then
    fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
      "rust-analyzer"
    ]
  else
    fenix.latest.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ];
  # rustAnalyzer = fenix.latest.rust-analyzer;
  devPackages = [ asdf rustComponents ];
  basePackages = [
    htop
    statix
    ripgrep
    fd
    exa
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
    nodejs
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

in builtins.concatLists [
  doomEmacsDeps
  devPackages
  basePackages
  macPackages
  linuxPackages
  rustUtils
]
