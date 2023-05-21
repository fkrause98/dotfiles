{ config, pkgs, ... }:
let vars = import ./vars.nix;
in with pkgs;
let
  macPackages = if vars.isMac then [ elixir-ls iterm2 ngrok ] else [ ];
  archPackages = if vars.isLinux then [
    xsel
    (pkgs.callPackage ./arch/rate_mirrors.nix { inherit pkgs; })
  ] else
    [ ];
  devPackages = [
    asdf-vm
    rustup
    protobuf
    libiconv
    omnisharp-roslyn
    dotnet-sdk_7
  ];
  basePackages = [
    statix
    ripgrep
    fd
    exa
    bat
    tealdeer
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
    jetbrains-mono
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
