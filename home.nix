{ config, pkgs, ... }:
let
  isMac = builtins.currentSystem == "darwin";
  isLinux = builtins.currentSystem == "linux";
  # The emacs aarch64 is currently broken, so
  # ignore it for now.
  emacs = if isLinux then [pkgs.emacs-gtk] else [];
  iterm = if isMac then [pkgs.iterm2] else [];
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fran";
  home.homeDirectory = "/Users/fran";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.neovim
    pkgs.asdf-vm
    pkgs.ripgrep
    pkgs.exa
    pkgs.bat
    pkgs.fish
    pkgs.tmux
    pkgs.direnv
    pkgs.rustup
    pkgs.gnumake
    pkgs.neofetch
    pkgs.elixir-ls
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ]
  ++
  emacs
  ++
  iterm
  ;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fran/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = ''
    #   # List of plugins
    #   set -g @plugin 'tmux-plugins/tpm'
    #   set -g @plugin 'tmux-plugins/tmux-sensible'
    #   set -g @plugin 'jabirali/tmux-tilish'
    #   set-window-option -g mode-keys vi
    #   # Keybinds
    #   bind-key -T copy-mode-vi v send -X begin-selection
    #   bind-key -T copy-mode-vi V send -X select-line
    #   bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
    #   unbind -T copy-mode MouseDragEnd1Pane
    #   unbind -T copy-mode-vi MouseDragEnd1Pane
    #   bind-key -T copy-mode-vi y send-keys -X copy-selection
    #   bind-key -T vi-copy    MouseDragEnd1Pane copy-selection -x
    #   bind-key -T copy-mode-vi y send -X copy-selection-no-clear
    #   set-option -g mouse on
    #   setw -g mode-mouse on
    #   set -g terminal-overrides 'xterm*:smcup@:rmcup@'
    #   # Other examples:
    #   # set -g @plugin 'github_username/plugin_name'
    #   # set -g @plugin 'github_username/plugin_name#branch'
    #   # set -g @plugin 'git@github.com:user/plugin'
    #   # set -g @plugin 'git@bitbucket.com:user/plugin'
    #   set-option -g status-position top
    #   # Start windows and panes at 1, not 0
    #   set -g base-index 1
    #   setw -g pane-base-index 1

    #   # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    #   run '~/.tmux/plugins/tpm/tpm'
    #   '';
  };
}
