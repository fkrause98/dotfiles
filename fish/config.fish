      ## Alias ls to exa
      function ls --wraps=exa --description 'alias ls exa'
      exa $argv
      end
      ## Vim aliases
      function vi --wraps=vim --description 'alias vi vim'
      vim $argv
      end
      ## Vim aliases
      function nvim --wraps=vim --description 'alias nvim vim'
      vim $argv
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
      if [ (uname -s) = "darwin" ]
      # Code to be executed if condition is true
        ulimit -n 200000
        ulimit -u 2048
      end
      ## Add doom binary to path
      fish_add_path $HOME/.config/emacs/bin/doom
