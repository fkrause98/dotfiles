      ## Alias ls to exa
      function ls --wraps=exa --description 'alias ls exa'
          exa $argv
      end
      ## Vim aliases
      function vi --wraps=vim --description 'alias vi vim'
          vim $argv
      end

      function nvim --wraps=vim --description 'alias nvim vim'
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
          function pbpaste --wraps='xsel --clipboard --output' --description 'alias pbpaste=xsel --clipboard --output'
              xsel --clipboard --output $argv
          end
          function pbcopy --wraps='xsel --clipboard --input' --description 'alias pbcopy=xsel --clipboard --input'
              xsel --clipboard --input $argv
          end
      end
      ## Add doom binary to path
      fish_add_path $HOME/.config/emacs/bin/

      # Defined via `source`
      function nix-shell --description 'alias nix-shell nix-shell --run fish'
          command nix-shell --run fish $argv
      end
