      ## Alias ls to exa
      function ls --wraps=exa --description 'alias ls exa'
          exa $argv
      end
      ## Alias em to emacs -nw 
      function em --wraps="emacs -nw" --description 'alias "emacs -nw" em'
	      emacs -nw $argv
      end
      ## Alias ec to emacs client
      function ec --wraps="emacsclient -a=vim" --description 'alias "emacs -nw" em'
        emacsclient -nw -a=vim $argv
      end
      
      ## Vim aliases
      function vi --wraps=vim --description 'alias vi vim'
          vim $argv
      end

      if test ! -d ~/.config/fish/completions
          mkdir -p ~/.config/fish/completions
      end

      ## Add asdf completions
      set asdf_completions =
      if test -d ~/.asdf/completions/asdf.fish
          ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
      end
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
      if [ (uname -s) = Darwin ]
          ulimit -n 200000
          ulimit -u 2048
      end
      ## Add copy and paste as
      ## a terminal command
      if test (uname -s) = Linux
          # TODO: Make this use wl-copy for wayland base DEs.
          function pbpaste --wraps='xsel --clipboard --output' --description 'alias pbpaste=xsel --clipboard --output'
              xsel --clipboard --output $argv
          end
          function pbcopy --wraps='xsel --clipboard --input' --description 'alias pbcopy=xsel --clipboard --input'
              xsel --clipboard --input $argv
          end
      end
      ## Add doom binary to path
      fish_add_path $HOME/.config/emacs/bin/
      ## Vterm related
      function vterm_printf
          if begin
                  [ -n "$TMUX" ]; and string match -q -r "screen|tmux" "$TERM"
              end
              # tell tmux to pass the escape sequences through
              printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
          else if string match -q -- "screen*" "$TERM"
              # GNU screen (screen, screen-256color, screen-256color-bce)
              printf "\eP\e]%s\007\e\\" "$argv"
          else
              printf "\e]%s\e\\" "$argv"
          end
      end
      function vterm_prompt_end;
          vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
      end
      functions --copy fish_prompt vterm_old_fish_prompt
      function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
          # Remove the trailing newline from the original prompt. This is done
          # using the string builtin from fish, but to make sure any escape codes
          # are correctly interpreted, use %b for printf.
          printf "%b" (string join "\n" (vterm_old_fish_prompt))
          vterm_prompt_end
      end
      # Defined via `source`
      function nix-shell --description 'alias nix-shell nix-shell --run fish'
          command nix-shell --run fish $argv
      end

