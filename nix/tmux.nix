{pkgs}:
{
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      tilish
    ];
    extraConfig = ''
      # List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
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
      bind -n WheelUpPane copy-mode
      set-window-option -g exit-copy-past-bottom on
      set-option -g mouse on
      setw -g mode-mouse on
      set -g terminal-overrides 'xterm*:smcup@:rmcup@'
      unbind -T copy-mode MouseDragEnd1Pane
      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1
      set -g @plugin 'noscript/tmux-mighty-scroll'
      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'
    '';
}
