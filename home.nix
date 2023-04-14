{ config, pkgs, ... }:
let
  isMac = builtins.currentSystem == "darwin";
  isLinux = builtins.currentSystem == "x86_64-linux";
  iterm = if isMac then [ pkgs.iterm2 ] else [ ];
  elixir-ls = if isMac then [ pkgs.elixir-ls ] else [ ];
  home = builtins.getEnv "HOME";
  user = builtins.getEnv "USER";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user;
  home.homeDirectory = home;
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
  home.packages = with pkgs;
    [
      asdf-vm
      ripgrep
      fd
      exa
      bat
      tmux
      direnv
      rustup
      gnumake
      neofetch
      jq
      nixfmt
      neovim
      eb-garamond
      # DOOM Emacs dependencies
      binutils
      (ripgrep.override { withPCRE2 = true; })
      gnutls
      fd
      imagemagick
      zstd
      nodePackages.javascript-typescript-langserver
      sqlite
      editorconfig-core-c
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      (writeShellScriptBin "install-emacs" ''
        ${if isMac then "brew install emacs &&" else ""} + 
        git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
        ~/.config/emacs/bin/doom install
      '')
      (writeShellScriptBin "prompt-setup" ''
        !#/usr/bin/env fish
        fish_path=(status fish-path) exec $fish_path -C "emit _tide_init_install"
      '')
    ] ++ iterm ++ elixir-ls;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    ".config/doom" = {
      source = ./doom-emacs;
      recursive = true;
    };
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
    EDITOR = "vim";
    DOOMDIR = home + "" + "/dotfiles/doom-emacs";
    DOOMLOCALDIR = home + "" + "/doom-local";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Best editor ever
  programs.emacs = {
    # The emacs aarch64 is currently broken, so
    # ignore it for now, plus I'd rather
    # use railwaycat's port.
    enable = isLinux;
    package = pkgs.emacs-gtk;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };
  # Tmux config
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'jabirali/tmux-tilish'
      set-window-option -g mode-keys vi
      # Keybinds
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi V send -X select-line
      bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      unbind -T copy-mode MouseDragEnd1Pane
      unbind -T copy-mode-vi MouseDragEnd1Pane
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T vi-copy    MouseDragEnd1Pane copy-selection -x
      bind-key -T copy-mode-vi y send -X copy-selection-no-clear
      set-option -g mouse on
      setw -g mode-mouse on
      set -g terminal-overrides 'xterm*:smcup@:rmcup@'
      # Other examples:
      # set -g @plugin 'github_username/plugin_name'
      # set -g @plugin 'github_username/plugin_name#branch'
      # set -g @plugin 'git@github.com:user/plugin'
      # set -g @plugin 'git@bitbucket.com:user/plugin'
      set-option -g status-position top
      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
  # Vim  config
  programs.vim = {
    enable = true;
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
       set nu
       set rnu
       set expandtab
       set tabstop=2
       set softtabstop=2
       set shiftwidth=2
       " Remember last position on file
      if has("autocmd")
        augroup redhat
        autocmd!
        " When editing a file, always jump to the last cursor position
        autocmd BufReadPost *
          \ if line("'\"") > 0 && line ("'\"") <= line("$") |
          \   exe "normal! g'\"" |
          \ endif
        augroup END
      endif
    '';
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ## Alias ls to exa
      function ls --wraps=exa --description 'alias ls exa'
      exa $argv
      end
      ## Start asdf
      source ~/.asdf/asdf.fish
      ## Add asdf completions
      mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions 
      # To test python packages without installing them
      function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
        if set -q argv[2]
          set argv $argv[2..-1]
        end

        for el in $argv
          set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end

        nix-shell -p $ppkgs
      end
      ${if isMac then ''
        ## Fix issues with not enough file descriptors
        ulimit -n 200000
        ulimit -u 2048
      '' else
        ""}
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "z";
        src = z.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "fzf";
        src = fzf.src;
      }
      {
        name = "tide";
        src = tide.src;
      }
      {
        name = "done";
        src = done.src;
      }
      {
        name = "fish-git-abbr";
        src = pkgs.fetchFromGitHub {
          owner = "lewisacidic";
          repo = "fish-git-abbr";
          rev = "abe95203b7fcb1eaa685bd5b75796b52bb7be884";
          sha256 = "UP+bk5luk6bNrMzI4eQkt9TzU8dkjEqGoEnlEh4fEK4=";
        };
      }
      {
        name = "fish-abbreviation-tips";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fish-abbreviation-tips";
          rev = "8ed76a62bb044ba4ad8e3e6832640178880df485";
          sha256 = "F1t81VliD+v6WEWqj1c1ehFBXzqLyumx5vV46s/FZRU=";
        };
      }
      {
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "fisher";
          rev = "67bec738dbec2442d05d09ef72b2be82acb1d774";
          sha256 = "rtWPiEalxUhZQMZ8Ydk3E4wKke+Pdl7WaM4iOEKYuvM=";
        };
      }
      {
        name = "replay";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "replay.fish";
          rev = "bd8e5b89ec78313538e747f0292fcaf631e87bd2";
          sha256 = "bM6+oAd/HXaVgpJMut8bwqO54Le33hwO9qet9paK1kY=";
        };
      }
    ];
  };
}
