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

      set fish_completions = ~/.config/fish/completions
      if test ! -d fish_completions
          mkdir -p fish_completions
      end

      ## Add asdf completions
      set asdf_completions = ~/.asdf/completions/asdf.fish
      if test -d asdf_completions
          ln -s asdf_completions ~/.config/fish/completions
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
      if [ (uname -s) = darwin ]
          # Code to be executed if condition is true
          ulimit -n 200000
          ulimit -u 2048
      end
      ## Add doom binary to path
      fish_add_path $HOME/.config/emacs/bin/doom

      # Defined via `source`
      function nix-shell --description 'alias nix-shell nix-shell --run fish'
          command nix-shell --run fish $argv
      end
