{ config, pkgs, ... }:
let
 vars = import ./vars.nix;
in with pkgs;
let
  macPackages = if vars.isMac then [
    elixir-ls
    iterm2
    ngrok
    protobuf
    libiconv
    omnisharp-roslyn
    dotnet-sdk_7
  ] else
    [ ];
  linuxPackages = if vars.isLinux then [
    xsel
    (pkgs.callPackage ./arch/rate_mirrors.nix { inherit pkgs; })
    ((emacsPackagesFor emacsNativeComp).emacsWithPackages (epkgs: [ epkgs.vterm ]))
  ] else
    [ ];
  devPackages = [ asdf-vm rustup ];
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

in builtins.concatLists [ doomEmacsDeps devPackages basePackages macPackages linuxPackages ]
