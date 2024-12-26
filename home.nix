{ config, lib, pkgs, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manager
  home.username = "fran";
  home.homeDirectory = "/home/fran";
  nixpkgs.config.allowUnfree = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.packages = import ./nix-configs/packages.nix {
    config = config;
    pkgs = pkgs;
  };
  home.file = {
    ".config/doom" = {
      source = ./doom;
      recursive = true;
    };
  };
  home.sessionVariables = {
    # The best $EDITOR
    EDITOR = "vim";
  };
  # Manage XDG env variables for Linux programs.
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.tmux.enable = true;
  programs.vim = import ./nix-configs/vim.nix { };
  programs.fish = import ./nix-configs/fish.nix { pkgs = pkgs; };
  programs.git = import ./nix-configs/git.nix { };
  programs.direnv = import ./nix-configs/direnv.nix;
}
