{ config, pkgs, vars, ... }: {

  # Home Manager needs a bit of information about you and the paths it should
  # manager
  home.username = "fran";
  home.homeDirectory = vars.home;
  nixpkgs.config.allowUnfree = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = import ./nix-configs/packages.nix {
    config = config;
    pkgs = pkgs;
  };
  home.file = {
    ".config/doom" = {
      source = ./doom;
      recursive = true;
    };
    ".gnupg/gpg-agent.conf" = {
      source = ./gpg-agent.conf;
      enable = vars.isMac;
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

  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages
      (epkgs: [ epkgs.vterm ]);
  };

  programs.fish = import ./nix-configs/fish.nix { pkgs = pkgs; };
  programs.git = import ./nix-configs/git.nix { };
  programs.direnv = import ./nix-configs/direnv.nix;
}
