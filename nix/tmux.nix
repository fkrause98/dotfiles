{ pkgs, fishNixPath }: {
  enable = true;
  plugins = with pkgs.tmuxPlugins; [
    tilish
    better-mouse-mode
    cpu
    sensible
    resurrect
    prefix-highlight
    open
    # cool theme
    #power-theme
    # save history to file
    logging
    fpp
    # Tmux hints
    fingers
    extrakto
    continuum
    yank
  ];
  shell = fishNixPath;
  sensibleOnTop = false;
  baseIndex = 1;
  keyMode = "vi";
  escapeTime = 0;
  mouse = true;
  extraConfig = ''
    set-option -g status-position top
    # Keybinds
    bind-key -T copy-mode-vi v send -X begin-selection
    bind-key -T copy-mode-vi V send -X select-line
    bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
  '';
}
