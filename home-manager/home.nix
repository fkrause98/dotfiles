{ config, pkgs, ... }:
let vars = import ./vars.nix;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manager
  # Use mkdefault to not clash with nixos settings
  home.username = pkgs.lib.mkDefault vars.user;
  home.homeDirectory = pkgs.lib.mkDefault vars.home;
  nixpkgs.config.allowUnfree = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
  home.packages = import ./packages.nix {
    config = config;
    pkgs = pkgs;
  };

  home.file = {
    ".config/doom" = {
      source = vars.emacsConfig;
      recursive = true;
    };
    # ".emacs.d" = {
    #   source = ../emacs-vanilla;
    #   recursive = true;
    # };
  };
  home.sessionVariables = {
    # The best $EDITOR
    EDITOR = "vim";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.tmux = import ./tmux.nix {
    pkgs = pkgs;
    fishNixPath = vars.fishNixPath;
  };
  programs.vim = import ./vim.nix { };
  programs.fish = import ./fish.nix { pkgs = pkgs; };
  programs.git = import ./git.nix { };
  services = {
    emacs = {
      enable = vars.isLinux;
      startWithUserSession = vars.isLinux;
    };
  };
}
