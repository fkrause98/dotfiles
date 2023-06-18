{ config, pkgs, ... }:
let
  vars = import ./nix/vars.nix;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # managej
  home.username = vars.user;
  home.homeDirectory = vars.home;
  nixpkgs.config.allowUnfree = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.
  home.packages = import ./nix/packages.nix {
    config = config;
    pkgs = pkgs;
  };

  home.file = {
    ".config/doom" = {
      source = vars.emacsConfig;
      recursive = true;
    };
    ".emacs.d" = {
      source = ./emacs-vanilla;
      recursive = true;
   }
  };

  home.sessionVariables = {
    # The best $EDITOR
    EDITOR = "vim";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.tmux = import ./nix/tmux.nix {
    pkgs = pkgs;
    fishNixPath = vars.fishNixPath;
  };
  programs.vim = import ./nix/vim.nix { };
  programs.fish = import ./nix/fish.nix { pkgs = pkgs; };
  programs.git = import ./nix/git.nix { };
  home.activation.postSwitch = "
      echo -e '\\033[36;49;1mRunning post switch commands!\\033[36;49;1m'
      ${vars.home}/.config/emacs/bin/doom sync
";
}
