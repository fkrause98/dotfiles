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
      ## Make iex remember command history
      set -x ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"
      # Defined via `source`
      function nix-shell --description 'alias nix-shell nix-shell --run fish'
          command nix-shell --run fish $argv
      end

