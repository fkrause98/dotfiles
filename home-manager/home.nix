{ config, lib, pkgs, vars, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manager
  # Use mkdefault to not clash with nixos settings
  home.username = pkgs.lib.mkDefault vars.user;
  home.homeDirectory = pkgs.lib.mkDefault vars.home;
  nixpkgs.config.allowUnfree = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.packages = import ./packages.nix {
    config = config;
    pkgs = pkgs;
    vars = vars;
  };
  home.file = {
    ".config/doom" = {
      source = vars.emacsConfig;
      recursive = true;
    };
  };
  home.sessionVariables = {
    # The best $EDITOR
    EDITOR = "vim";
  };
  # Manage XDG env variables for Linux programs.
  targets.genericLinux.enable = vars.isLinux;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.tmux.enable = true;
  programs.vim = import ./vim.nix { };
  programs.fish = import ./fish.nix { pkgs = pkgs; };
  programs.git = import ./git.nix { };
  programs.direnv = import ./direnv.nix;
  home.activation = {
    # This will make nix-installed applications on mac
    # available on spotlight.
    aliasHomeManagerApplications = if vars.isMac then
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        app_folder="${config.home.homeDirectory}/Applications/Home Manager Trampolines"
        rm -rf "$app_folder"
        mkdir -p "$app_folder"
        for app in $(find "$genProfilePath/home-path/Applications" -type l); do
            app_target="$app_folder/$(basename $app)"
            real_app="$(readlink $app)"
            echo "mkalias \"$real_app\" \"$app_target\"" >&2
            $DRY_RUN_CMD ${pkgs.mkalias}/bin/mkalias "$real_app" "$app_target"
        done
      ''
    else
      "";
  };
}
